return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      exclude_groups = { 'CursorLine', 'CursorLineNr'},
    },
    keys = {
      { "<leader>tt", "<cmd>TransparentToggle<cr>", desc = "Toggle transparent background" }
    }
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
