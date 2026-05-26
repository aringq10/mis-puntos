local tp = vim.g.transparent_enabled

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = tp
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = false
    },
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      }
    }
  },
  {
    "LunarVim/horizon.nvim",
    priority = 1000,
  }
}
