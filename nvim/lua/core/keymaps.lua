
-- See:
-- `:help vim.keymap`

-- Misc.
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  vim.keymap.set("n", "o", "o<Esc>", { desc = "Insert line below cursor" })
  vim.keymap.set("n", "O", "O<Esc>", { desc = "Insert line above cursor" })
  vim.keymap.set("n", "<Esc>", "<cmd>set nohls<CR>", { desc = "Turn off search highlight" })
  vim.keymap.set("n", "<leader>s", "<cmd>source $MYVIMRC<CR>", { desc = "Source neovim's config file" })

-- LSP
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })

-- Diagnostic
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Toggle between syntax and marker foldmethods
  vim.keymap.set("n", "<leader>fm", function()
    if vim.opt.foldmethod:get() == "marker" then
      vim.opt.foldmethod = "syntax"
      print("Folding: syntax")
    else
      vim.opt.foldmethod = "marker"
      print("Folding: marker")
    end
  end, { desc = "Toggle between marker and syntax folding" })


-- Autocommands
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.hl.on_yank()
    end,
  })


