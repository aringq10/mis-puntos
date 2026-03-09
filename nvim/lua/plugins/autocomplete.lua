-- https://github.com/Saghen/blink.cmp

return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      { -- Snippet Engine
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          { -- premade snippets
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      -- :h blink-cmp-config-keymap for presets and defining keymaps
      keymap = { preset = 'default', },
      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps

      -- see :h blink-cmp-config-<name> for options, where <name>: appearance, sources...
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
          treesitter_highlighting = true,
          window = { border = "rounded" }
        },
        keyword = { range = 'full' },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = true } },
      },
      term = { enabled = false }, -- Tried the terminal completion but didn't seem to work
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true },
    },
  },
}
