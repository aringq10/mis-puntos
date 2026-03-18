
-- See:
-- `:help vim.keymap`

local map = vim.keymap.set

-- Misc.
  map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
  map("n", "o", "o<Esc>", { desc = "Insert line below cursor" })
  map("n", "O", "O<Esc>", { desc = "Insert line above cursor" })
  map("n", "<Esc>", "<cmd>set nohls<CR>", { desc = "Turn off search highlight" })
  map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
  map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Window and Tab navigation
  map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
  map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
  map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
  map("n", "<leader>wh", "<C-w>H", { desc = "Move Window Left", remap = true })
  map("n", "<leader>wj", "<C-w>J", { desc = "Move Window Down", remap = true })
  map("n", "<leader>wk", "<C-w>K", { desc = "Move Window Up", remap = true })
  map("n", "<leader>wl", "<C-w>L", { desc = "Move Window Right", remap = true })
  map("n", "<leader>ws", "<C-W>s", { desc = "Split Window Horizontally", remap = true })
  map("n", "<leader>wv", "<C-W>v", { desc = "Split Window Vertically", remap = true })
  map("n", "<leader>wt", "<C-W>T", { desc = "Move window to new tab", remap = true })
  map("n", "<leader>wd", "<C-W>q", { desc = "Delete Window", remap = true })

  map("n", "t", "<cmd>tabnext<cr>", { desc = "Next Tab" })
  map("n", "t", function()
    local count = vim.v.count
    if count > 0 then
      vim.cmd("tabnext " .. count)
    else
      vim.cmd("tabnext")
    end
  end, { desc = "Next Tab" })
  map("n", "T", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
  map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
  map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })

-- Move Lines
  map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Line Down" })
  map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Line Up" })
  map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
  map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
  map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Line Down" })
  map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Line Up" })

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

-- highlights under cursor
  map("n", "<leader>tsp", vim.show_pos, { desc = "Inspect Pos" })
  -- "a" - toggle display of anonymous nodes, "I" - node source lang,
  -- "o" - query editor, <Enter> - jump to node, folding also works.
  map("n", "<leader>tst", function() vim.treesitter.inspect_tree() vim.api.nvim_input("I") end, { desc = "Inspect Tree" })
