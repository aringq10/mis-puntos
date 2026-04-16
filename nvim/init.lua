-- Mostly based on https://github.com/nvim-lua/kickstart.nvim,
-- very cool stuff

-- Copy or symlink the contents of this folder to ~/.config/nvim/
-- or wherever the config files are in your system

-- /lua/core/    - core config files
-- /lua/config/  - other config files
-- /lua/plugins/ - .lua files for plugins


-- Set global vars
  vim.g.mapleader      = '\\'
  vim.g.maplocalleader = '\\'
  vim.g.have_nerd_font = true
  vim.g.colorscheme    = 'tokyonight-moon'


require("config.lazy")

require("core.keymaps")

require("core.opts")

require("core.autocmds")
