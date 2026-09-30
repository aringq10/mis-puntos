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
      open_multiple_tabs = true,
      highlight_hovered_buffers_in_same_directory = false,
      floating_window_scaling_factor = 0.7,
      keymaps = {
        show_help = "<f1>",
      },
    },
    config = function(_, opts)
      require("yazi").setup(opts)

      local function yazi_border_bg_none()
        local border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
        vim.api.nvim_set_hl(0, "YaziFloatBorder", { fg = border.fg, bg = "NONE" })
      end

      yazi_border_bg_none()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function() vim.schedule(yazi_border_bg_none) end,
      })
    end,
  },
}
