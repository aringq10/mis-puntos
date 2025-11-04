-- Copy or link the contents of this folder to ~/.confid/nvim/

-- /lua/lsp/     - autocompletion settigns for different language servers
-- /lua/plugins/ - .lua files for plugins

-- PLUGINS ---------------------------------------------------------------- {{{

    require("config.lazy")
 
-- }}}


-- AUTOCOMPLETION --------------------------------------------------------- {{{

    local cmp = require("cmp")

-- Enable autocompletion
    cmp.setup({
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = {
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<Tab>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-s>'] = cmp.mapping.close()
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "buffer" }
        },
    })
    -- `/` cmdline setup.
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
    })

-- Attach LSP from /lua/lsp/*
    local lsp_path = vim.fn.stdpath("config") .. "/lua/lsp/"
    local files = vim.fn.globpath(lsp_path, "*.lua", false, true)

    for _, file in ipairs(files) do
        local module = "lsp." .. vim.fn.fnamemodify(file, ":t:r")
        pcall(require, module)
    end

-- }}}


-- STATUS LINE ------------------------------------------------------------ {{{

    vim.opt.statusline = ""
    -- Status line left side.
    vim.opt.statusline:append("%F %m %y %r %h")
    vim.opt.statusline:append(" %= ")
    -- Status line right side.
    vim.opt.statusline:append("%l/%L %c %p%%")

-- Show the status on the second to last line.
    vim.opt.laststatus=2

-- Hide ruler
    vim.opt.ruler = false;

-- }}}


-- MAPPINGS --------------------------------------------------------------- {{{

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "o", "o<Esc>")
vim.keymap.set("n", "O", "O<Esc>")

vim.keymap.set("n", "<leader>s", ":source ~/.config/nvim/init.lua<CR>")

-- Have nerdtree ignore certain files and directories.
vim.g.NERDTreeIgnore = {
  [[\.git$]],
  [[\.jpg$]],
  [[\.mp4$]],
  [[\.ogg$]],
  [[\.iso$]],
  [[\.pdf$]],
  [[\.pyc$]],
  [[\.odt$]],
  [[\.png$]],
  [[\.gif$]],
  [[\.db$]],
}

-- Default folding behavior
vim.opt.foldmethod = "syntax"
vim.opt.foldenable = true

-- toggle between syntax and marker
vim.keymap.set("n", "<leader>fm", function()
    if vim.opt.foldmethod:get() == "marker" then
        vim.opt.foldmethod = "syntax"
        print("Folding: syntax")
    else
        vim.opt.foldmethod = "marker"
        print("Folding: marker")
    end
end, { desc = "Toggle between marker and syntax folding" })

-- }}}

-- UI
vim.cmd("set nohls")
vim.cmd("syntax on")
vim.opt.number = true           -- line numbers
vim.opt.termguicolors = true    -- use 24 bit colors
vim.opt.cursorline = true       -- highlight line that cursor is on
vim.opt.showcmd = true          -- show command in bottom right
vim.opt.wrap = false
vim.cmd("colorscheme tokyonight")

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildignorecase = true
vim.opt.wildignore = {
    "*.docx",
    "*.jpg",
    "*.png",
    "*.gif",
    "*.pdf",
    "*.pyc",
    "*.exe",
    "*.flv",
    "*.img",
    "*.xlsx",
}
-- Tabs & indentation
vim.opt.tabstop = 4        -- Tab is equal to 4 spaces
vim.opt.expandtab = true   -- Pressing Tab inserts spaces
vim.opt.shiftwidth = 4     -- Indentation in space chars
vim.opt.softtabstop = 4    -- Backspace deletes 4 spaces
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

