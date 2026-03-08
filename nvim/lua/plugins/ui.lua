return {
  -- Other
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      exclude_groups = { 'CursorLine', 'CursorLineNr'},
    }
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
