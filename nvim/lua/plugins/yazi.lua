return {
  { -- File Explorer
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    enabled = true,
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        mode = { "n", "v" },
        "<leader>y",
        "<cmd>Yazi<cr>",
        desc = "Open Yazi",
      },
    },
    opts = {
      open_for_directories = false,
      open_multiple_tabs = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}
