
-- See:
-- `:help vim.keymap`

-- Misc.
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  vim.keymap.set("n", "o", "o<Esc>", { desc = "Insert line below cursor" })
  vim.keymap.set("n", "O", "O<Esc>", { desc = "Insert line above cursor" })
  vim.keymap.set("n", "<Esc>", "<cmd>set nohls<CR>", { desc = "Turn off search highlight" })
  vim.keymap.set("n", "<leader>s", "<cmd>source $MYVIMRC<CR>", { desc = "Source neovim's config file" })

-- Diagnostic
  vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

-- Toggle between syntax and marker foldmethods
  vim.keymap.set("n", "<leader>fm", function()
    if vim.opt.foldmethod:get() == "marker" then
      vim.opt.foldmethod = "expr"
      print("Folding: expr")
    else
      vim.opt.foldmethod = "marker"
      print("Folding: marker")
    end
  end, { desc = "Toggle between marker and expr folding" })

-- Fix a bug? with snippet jumping whenever I make a newline and press <Tab>
  local luasnip = require("luasnip")

  vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      return "\t"
    end
  end, { expr = true, silent = true })
