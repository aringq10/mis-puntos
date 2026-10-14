return {
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
        { '<leader>u', group = '[T]ree[S]itter' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it Diffview', mode = { 'n', 'v' } },
        { '<leader>w', group = '[W]indow Actions', mode = { 'n' } },
        { '<leader><Tab>', group = 'Tab Actions', mode = { 'n' } },
        { '<leader>k', group = 'Which [K]ey', mode = { 'n' } },
        { '<space>', group = 'Split/Join', mode = { 'n' } },
        { 's', group = 'Mini surround', mode = { 'n' } },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
        { 'gc', group = 'Line (Un)comment', mode = { 'n', 'v' } },
        { 'gb', group = 'Block (Un)comment', mode = { 'n', 'v' } },
        { ']', group = 'Next', mode = { 'n' } },
        { '[', group = 'Previous', mode = { 'n' } },
      },
    },
    keys = {
      {
        "<leader>kl",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "[K]eymaps for [L]ocal Buffer (which-key)",
      },
      {
        "<leader>kg",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "[K]eymaps [G]lobal (which-key)",
      }
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
