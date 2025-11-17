-- Mostly based on https://github.com/nvim-lua/kickstart.nvim,
-- very cool stuff

-- Copy or symlink the contents of this folder to ~/.config/nvim/
-- or wherever the config files are in your system

-- /lua/core/    - core config files
-- /lua/config/  - other config files
-- /lua/plugins/ - .lua files for plugins


-- Set custom leader key
  vim.g.mapleader      = '\\'
  vim.g.maplocalleader = '\\'

require("config/lazy") -- Load plugins via lazy.nvim

require("core/keymaps")

require("core/opts")

