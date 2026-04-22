local M = {}

local function select(capture, group)
  return function()
    require('nvim-treesitter-textobjects.select').select_textobject(capture, group)
  end
end

function M.setup()
  local map = { "x", "o" }
  vim.keymap.set(map, "af", select("@function.outer", "textobjects"))
  vim.keymap.set(map, "if", select("@function.inner", "textobjects"))
  vim.keymap.set(map, "ac", select("@class.outer", "textobjects"))
  vim.keymap.set(map, "ic", select("@class.inner", "textobjects"))
  vim.keymap.set(map, "as", select("@local.scope", "locals"))
end

return M
