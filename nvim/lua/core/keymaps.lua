
-- See:
-- `:help vim.keymap`

local map = vim.keymap.set

-- Misc.
  map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  map('n', '<Esc>', '<cmd>noh<CR>',{ silent = true, desc = "Turn off search highlight" })
  map("n", "o", "o<Esc>", { desc = "Insert line below cursor" })
  map("n", "O", "O<Esc>", { desc = "Insert line above cursor" })
  map("n", "<leader>r", function ()
    vim.wo.wrap = not vim.wo.wrap
    vim.wo.linebreak = vim.wo.wrap
  end, { desc = "Toggle wrap" })
  map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open lazy.nvim" })
  map("n", "<leader>tr", "<cmd>ToggleRelNum<CR>", {})

-- Movement in wrap mode
  map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
  map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
  map({ "n", "x" }, "0", function() return vim.wo.wrap and (vim.v.count == 0 and 'g0' or '0') or '0' end, { desc = "Start", expr = true, silent = true })
  map({ "n", "x" }, "$", function() return vim.wo.wrap and (vim.v.count == 0 and 'g$' or '$') or '$' end, { desc = "End", expr = true, silent = true })

-- Window and Tab navigation
  map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
  map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
  map("n", "<leader>wh", "<C-w>H", { desc = "Move window left", remap = true })
  map("n", "<leader>wj", "<C-w>J", { desc = "Move window down", remap = true })
  map("n", "<leader>wk", "<C-w>K", { desc = "Move window up", remap = true })
  map("n", "<leader>wl", "<C-w>L", { desc = "Move window right", remap = true })
  map("n", "<leader>ws", "<C-W>s", { desc = "Split window horizontally", remap = true })
  map("n", "<leader>wv", "<C-W>v", { desc = "Split window vertically", remap = true })
  map("n", "<leader>wt", "<C-W>T", { desc = "Move window to new tab", remap = true })
  map("n", "<leader>wd", "<C-W>q", { desc = "Delete window", remap = true })
  map("n", "<leader>wo", "<C-W>o", { desc = "Delete all other windows", remap = true })

  map("n", "t", function()
    local count = vim.v.count
    if count > 0 then
      vim.cmd("tabnext " .. count)
    else
      vim.cmd("tabnext")
    end
  end, { desc = "Next tab" })
  map("n", "T", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
  map("n", "<leader><Tab><Tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
  map("n", "<leader><Tab>c", "<cmd>tabclose<cr>", { desc = "Close tab" })
  map("n", "<leader><Tab>o", "<cmd>tabclose<cr>", { desc = "Close all other tabs" })

-- Move Lines
  -- map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Line Down" })
  -- map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Line Up" })
  -- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
  -- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
  -- map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Line Down" })
  -- map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Line Up" })
  --
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
