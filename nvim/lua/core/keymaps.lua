
-- See:
-- `:help vim.keymap`

local map = vim.keymap.set

-- Misc.
  map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  map('n', '<Esc>', '<cmd>noh<CR>',{ silent = true, desc = "Turn off search highlight" })
  map("n", "o", "o<Esc>", { desc = "Insert line below cursor" })
  map("n", "O", "O<Esc>", { desc = "Insert line above cursor" })
  map("n", "<leader>tw", function ()
    vim.wo.wrap = not vim.wo.wrap
    vim.wo.linebreak = vim.wo.wrap
  end, { desc = "Toggle wrap" })
  map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open lazy.nvim" })
  map("n", "<leader>tr", function() vim.o.relativenumber = not vim.o.relativenumber end, { desc = "Toggle relative nums" })

-- Movement in wrap mode
  map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
  map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
  map({ "n", "x" }, "0", function() return vim.wo.wrap and (vim.v.count == 0 and 'g0' or '0') or '0' end, { desc = "Start", expr = true, silent = true })
  map({ "n", "x" }, "$", function() return vim.wo.wrap and (vim.v.count == 0 and 'g$' or '$') or '$' end, { desc = "End", expr = true, silent = true })

-- Windows
  map("n", "<leader>wx", "<C-W>s", { desc = "Split window horizontally", remap = true })
  map("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically", remap = true })
  map("n", "<leader>wc", "<C-W>q", { desc = "Close window", remap = true })
  map("n", "<leader>wo", "<C-W>o", { desc = "Close all other windows", remap = true })
  map("n", "<leader>wh", "<C-W>H", { desc = "Move window left", remap = true })
  map("n", "<leader>wj", "<C-W>J", { desc = "Move window down", remap = true })
  map("n", "<leader>wk", "<C-W>K", { desc = "Move window up", remap = true })
  map("n", "<leader>wl", "<C-W>L", { desc = "Move window right", remap = true })
  map("n", "<leader>wt", "<C-W>T", { desc = "Move window to new tab", remap = true })
  map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
  map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Tabs
  map("n", "<leader><Tab>n", "<cmd>tabnew<cr>", { desc = "New tab" })
  map("n", "<leader><Tab>c", "<cmd>tabclose<cr>", { desc = "Close tab" })
  map("n", "<leader><Tab>o", "<cmd>tabonly<cr>", { desc = "Close all other tabs" })
  local function tab_move(dir)
    local cur = vim.fn.tabpagenr()
    local last = vim.fn.tabpagenr("$")
    if last == 1 then return end

    if dir > 0 then
      vim.cmd(cur == last and "tabmove 0" or "tabmove +1")
    else
      vim.cmd(cur == 1 and "tabmove $" or "tabmove -1")
    end
  end
  map("n", "<leader><Tab>.", function() tab_move(1) end, { desc = "Move tab right" })
  map("n", "<leader><Tab>,", function() tab_move(-1) end, { desc = "Move tab left" })
  map("n", "<C-m>", "gt", { desc = "Go to right tab" })
  map("n", "<C-n>", "gT", { desc = "Go to left tab" })

-- Diagnostic
  local diagnostic_goto = function(next, severity)
    return function()
      vim.diagnostic.jump({
        count = (next and 1 or -1) * vim.v.count1,
        severity = severity and vim.diagnostic.severity[severity] or nil,
        float = true,
      })
    end
  end
  map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
  map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
  map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
  map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
  map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
  map("n", "]h", diagnostic_goto(true, "HINT"), { desc = "Next Hint" })
  map("n", "[h", diagnostic_goto(false, "HINT"), { desc = "Prev Hint" })
