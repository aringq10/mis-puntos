# nvim path cheatsheet

Where files live, where nvim look, when files run.

## stdpaths

XDG-based. Get via `vim.fn.stdpath('<what>')`.

| `what` | Default path (Linux) | Purpose |
|---|---|---|
| `config` | `~/.config/nvim` | `init.lua`, `lua/`, `colors/`, `after/` |
| `data` | `~/.local/share/nvim` | plugin installs, `site/`, shada |
| `state` | `~/.local/state/nvim` | shada, undo, swap, logs |
| `cache` | `~/.cache/nvim` | TS parser cache, throwaway |
| `log` | `~/.local/state/nvim` | `lsp.log`, `treesitter.log` (same as state) |
| `run` | `$XDG_RUNTIME_DIR/nvim` | sockets, IPC |
| `config_dirs` | list from `$XDG_CONFIG_DIRS` | extra read-only configs |
| `data_dirs` | list from `$XDG_DATA_DIRS` | extra read-only data |

Override via XDG env vars or `$NVIM_APPNAME` (swap trailing `nvim` for parallel configs).

## runtimepath

Comma-separated dir list nvim scan for runtime files. Inspect:
```lua
:lua for _, p in ipairs(vim.opt.runtimepath:get()) do print(p) end
```

Default contents:
```
$VIMRUNTIME
$VIM/vimfiles
~/.config/nvim                          (stdpath('config'))
~/.local/share/nvim/site                (stdpath('data')/site)
~/.local/share/nvim/site/pack/*/start/* (auto packadd)
<plugin install dirs>                   (added by lazy/packer/etc.)
…all above's after/ siblings, reverse order…
```

Manipulate:
```lua
vim.opt.runtimepath:append('~/code/x')
vim.opt.runtimepath:prepend('~/code/y')
vim.opt.runtimepath:remove('~/code/z')
```

## auto-loaded dirs on rtp

### Eager — sourced at startup

| Dir | When |
|---|---|
| `plugin/**/*.{lua,vim}` | After `init.lua`, before `VimEnter` |
| `ftdetect/*.{lua,vim}` | Once at startup, registers ft detection |

### Reactive — sourced on event

| Dir | Trigger |
|---|---|
| `ftplugin/<ft>.lua` or `ftplugin/<ft>/*.lua` | `FileType` event for `<ft>` |
| `indent/<ft>.lua` | `FileType` event |
| `syntax/<ft>.lua` | `FileType` event (if `:syntax on`) |
| `colors/<name>.lua` | `:colorscheme <name>` |
| `compiler/<name>.lua` | `:compiler <name>` |
| `keymap/<name>.lua` | `:set keymap=<name>` |
| `spell/<lang>.*.spl` | `:set spell` / `:set spelllang=<lang>` |
| `parser/<lang>.so` | `vim.treesitter.start(bufnr, lang)` |
| `queries/<lang>/<name>.scm` | `vim.treesitter.query.get(lang, name)` |

### Manual only — not auto-sourced

| Dir | Trigger |
|---|---|
| `lua/<modname>.lua` | `require('modname')` |
| `lua/<modname>/init.lua` | `require('modname')` |
| `autoload/<name>.vim` | `name#func()` call (Vimscript only) |
| `doc/*.txt` | `:help` after `:helptags` indexing |
| `pack/<grp>/start/<plug>/` | Auto packadd at startup |
| `pack/<grp>/opt/<plug>/` | Only on `:packadd <plug>` |

## after/ mechanism

Each runtime dir above has `after/` sibling. Nvim auto-append `after/` versions to rtp **in reverse order**, so files inside run **last**. Use for overriding plugin defaults without forking.

```
~/.config/nvim/after/ftplugin/python.lua   ← runs after every other python ftplugin
~/.config/nvim/after/colors/tokyonight.lua ← overrides colorscheme hl after load
~/.config/nvim/after/queries/lua/highlights.scm ← extends TS query (use ; extends)
```

`after/lua/foo.lua` does **not** work for `require('foo')` — `after/` only applies to auto-sourced dirs, not `lua/`.

## treesitter specifics

| File | Purpose | Consumer |
|---|---|---|
| `parser/<lang>.so` | Compiled parser | core (`vim.treesitter.start`) |
| `queries/<lang>/highlights.scm` | Syntax color captures | core highlighter |
| `queries/<lang>/injections.scm` | Embedded lang regions | core highlighter |
| `queries/<lang>/folds.scm` | Fold regions | core (`foldexpr`) |
| `queries/<lang>/indents.scm` | Indent rules | nvim-treesitter |
| `queries/<lang>/locals.scm` | Scope tracking | nvim-treesitter, refactor plugins |
| `queries/<lang>/textobjects.scm` | Custom textobjects | nvim-treesitter-textobjects |
| `queries/<lang>/<custom>.scm` | Anything | whoever calls `query.get(lang, name)` |

**Parser resolution**: first match on rtp wins.
**Query resolution**: all matches merged. Directives at top of file:
- `; extends` — append to base
- `; inherits: <other_lang>` — load `queries/<other_lang>/<same_file>.scm` as base

Inspect:
```lua
:lua =vim.treesitter.query.get_files('php', 'highlights')
:lua =vim.api.nvim_get_runtime_file('parser/*.so', true)
```

## require() resolution

`require('a.b.c')` walk rtp, look for:
```
<rtpdir>/lua/a/b/c.lua
<rtpdir>/lua/a/b/c/init.lua
```

`?.lua` beat `?/init.lua` within same dir. First match on rtp wins. Cached in `package.loaded` forever (clear with `package.loaded.foo = nil`).

Not via require: `package.preload` (preloaded modules), `package.path`'s `./?.lua` fallback (cwd), custom searchers.

Inspect:
```lua
:lua =vim.loader.find('a.b.c')   -- which file resolves
:lua =package.path                -- raw search patterns
:lua =package.loaded              -- everything required so far
:lua =package.preload             -- baked-in modules (vim.fs, vim.fn, etc.)
```

## startup order

```
1. rtp default set
2. init.lua sourced
3. plugin/**/*.lua across rtp (eager)
4. ftdetect/*.lua across rtp
5. after/plugin/**/*.lua, after/ftdetect/*.lua
6. VimEnter fired
7. Buffer load → ft detection → 'filetype' set → FileType event
   → ftplugin/, indent/, syntax/ sourced (and their after/ versions)
```

## conventional install locations

| Purpose | Path |
|---|---|
| User config | `~/.config/nvim/` |
| User plugins (lazy.nvim) | `~/.local/share/nvim/lazy/<plug>/` |
| User plugins (packer/native) | `~/.local/share/nvim/site/pack/<grp>/{start,opt}/<plug>/` |
| User site (manual drop) | `~/.local/share/nvim/site/{colors,parser,queries,plugin,…}/` |
| Mason binaries | `~/.local/share/nvim/mason/` |
| TS parsers (nvim-treesitter) | `<nvim-treesitter-install-dir>/parser/` |
| TS parsers (shipped) | `$VIMRUNTIME/parser/` (if any) |
| Shipped runtime | `$VIMRUNTIME` |

## LSP (builtin, nvim 0.11+)

Two APIs:

```lua
vim.lsp.config(name, opts)   -- declare/merge server config
vim.lsp.enable(names)        -- activate, sets up FileType autocmd internally
```

`enable` wires its own autocmd. You don't write one to start servers.

### config file resolution

Nvim auto-load `lsp/<server_name>.lua` from any rtp dir. File return config table:

```
~/.config/nvim/lsp/luals.lua            ← user
<plugin>/lsp/luals.lua                  ← e.g. nvim-lspconfig ships here
$VIMRUNTIME/lsp/...                     ← (if shipped)
```

Then:
```lua
vim.lsp.enable('luals')   -- finds lsp/luals.lua on rtp, starts on matching ft
```

### file format

```lua
-- ~/.config/nvim/lsp/luals.lua
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git' },
  settings = { Lua = { ... } },
  on_attach = function(client, bufnr) ... end,
}
```

Fields: `cmd`, `filetypes`, `root_markers`, `root_dir` (fn), `settings`, `init_options`, `capabilities`, `on_attach`, `handlers`, `cmd_env`, `cmd_cwd`, `name`.

### merge order

`vim.lsp.config('luals', {...})` deep-merge with `lsp/luals.lua` from rtp. Override single fields without rewriting whole config.

`vim.lsp.config('*', {...})` set defaults for every server (capabilities, on_attach, etc.).

### events

Don't write FileType autocmd. Use `LspAttach` for per-client/per-buffer setup:

```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- keymaps...
  end,
})
```

`LspDetach` for cleanup. `LspProgress` for progress notifications.

### Mason: PATH not rtp

Mason install LSPs/formatters/linters as **binaries**, put `~/.local/share/nvim/mason/bin/` on `vim.env.PATH`. Not on rtp. nvim spawn process, OS resolve via PATH.

```
~/.local/share/nvim/mason/
├── bin/                ← prepended to PATH
└── packages/<name>/    ← real install
```

mason.nvim plugin itself (Lua code) on rtp normally. Tools under `packages/` not on rtp.

mason-lspconfig.nvim bridge: map mason package name ↔ lspconfig server name, drive `vim.lsp.enable` for installed servers.

### inspect

```lua
:lua =vim.lsp.config['luals']            -- resolved config
:lua =vim.lsp.get_clients()              -- running clients
:checkhealth vim.lsp                      -- full LSP status
:LspInfo                                  -- nvim-lspconfig view (if installed)
:lua =vim.env.PATH                        -- mason bin should be in here
:lua =vim.fn.exepath('lua-language-server')  -- should resolve to mason/bin/...
```

### mental model

> **Plugins** (Lua code nvim run) → rtp.
> **Tools** (binaries nvim spawn) → PATH.
> **LSP configs** (`lsp/<name>.lua`) → rtp, auto-resolved by `vim.lsp.enable`.

## inspection one-liners

```lua
:lua =vim.fn.stdpath('config')
:lua =vim.opt.runtimepath:get()
:lua =vim.api.nvim_get_runtime_file('plugin/**/*.lua', true)
:lua =vim.api.nvim_get_runtime_file('parser/*.so', true)
:lua =vim.api.nvim_get_runtime_file('queries/lua/*.scm', true)
:lua =vim.api.nvim_get_runtime_file('lsp/*.lua', true)
:lua =vim.treesitter.highlighter.active
:lua =vim.b.current_syntax
:verbose set filetype?
```
