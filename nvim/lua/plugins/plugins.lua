return {
  -- colorschemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = vim.g.transparent_enabled
    },
  },
  { "morhetz/gruvbox" },
  -- Other
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      exclude_groups = { 'CursorLine', 'CursorLineNr'},
    }
  },
  {
    "preservim/nerdtree",
    lazy = false,
    keys = {
      { "<F3>", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" }
    }
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  }
}
