
-- See:
-- `:help vim.keymap`

-- Misc.
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  vim.keymap.set("n", "o", "o<Esc>", { desc = "Insert line below cursor" })
  vim.keymap.set("n", "O", "O<Esc>", { desc = "Insert line above cursor" })
  vim.keymap.set("n", "<Esc>", "<cmd>set nohls<CR>", { desc = "Turn off search highlight" })
  vim.keymap.set("n", "<leader>so", "<cmd>source $MYVIMRC<CR>", { desc = "Source neovim's config file" })
