return {
  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.ai').setup({ n_lines = 500 })
      require('mini.pairs').setup()
      require('mini.surround').setup()
      require('mini.notify').setup()
      require('mini.statusline').setup({
        use_icons = vim.g.have_nerd_font
      })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>ts', group = '[T]ree[S]itter' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
        { 'gc', group = 'Line (Un)comment', mode = { 'n', 'v' } },
        { 'gb', group = 'Block (Un)comment', mode = { 'n', 'v' } },
        { 'gn', group = 'Incremental Selection', mode = { 'n', 'v' } },
        { ']', group = 'Next', mode = { 'n' } },
        { '[', group = 'Previous', mode = { 'n' } },
        { '<leader>w', group = '[W]indow Actions', mode = { 'n' } },
        { '<leader><Tab>', group = 'Tab Actions', mode = { 'n' } },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
    config = function ()
      require('Comment').setup()
      local ft = require('Comment.ft')
      ft.css = {'//%s', '/*%s*/'}
    end
  },
}
