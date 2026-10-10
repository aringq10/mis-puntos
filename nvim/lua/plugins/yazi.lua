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
      open_file_function = function(chosen_file, config, state)
        local ext = vim.fn.fnamemodify(chosen_file, ":e"):lower()

        local external = {
          pdf = true, epub = true, djvu = true,
          mp4 = true, mkv = true, webm = true, mov = true, avi = true,
          mp3 = true, flac = true, ogg = true,
          png = true, jpg = true, jpeg = true, gif = true, webp = true,
          docx = true, xlsx = true, pptx = true,
        }

        if external[ext] then
          vim.ui.open(chosen_file)   -- xdg-open / open / start, depending on your OS
        else
          vim.cmd("edit " .. vim.fn.fnameescape(chosen_file))
        end
      end,
    },
  },
}
