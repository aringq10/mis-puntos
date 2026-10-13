return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = { 'folke/lazydev.nvim' },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      -- :h blink-cmp-config-keymap for presets and defining keymaps
      keymap = { preset = 'default', },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        documentation = { window = { border = "rounded" } },
        keyword = { range = 'full' },
        ghost_text = { enabled = false },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
        transform_items = function(_, items)
          return vim.tbl_filter(function(item)
            return item.kind ~= require('blink.cmp.types').CompletionItemKind.Snippet
          end, items)
        end
      },
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = {
          ghost_text = { enabled = false },
          menu = { auto_show = true }
        },
      },
      term = { enabled = false }, -- Tried the terminal completion but didn't seem to work
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true },
    },
  },
}
