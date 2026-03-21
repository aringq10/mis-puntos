-- Autocommands
-- {
--    augroup_name = {
--      {events, pattern, description, callback_or_command},
--      ...
--    },
--    ...
--  }

local autoCommands = {
  -- folds = {
  --   {"BufReadPost,FileReadPost", "*", "Open all folds on buffer open", "normal zR"}
  -- },
  yank = {
    {
      "TextYankPost",
      "*",
      "Highlight when yanking (copying) text",
      function()
        vim.hl.on_yank()
      end
    }
  }
}

local M = {}

--- Create multiple augroups and autocmds
-- @param definitions table: { augroup_name = { {events, pattern, description, callback_or_command}, ... }, ... }
function M.nvim_create_augroups(definitions)
  for group_name, cmds in pairs(definitions) do
    -- Create or get the augroup
    local group_id = vim.api.nvim_create_augroup(group_name, { clear = true })

    for _, def in ipairs(cmds) do
      local events = def[1]
      local pattern = def[2]
      local desc = def[3]
      local command = def[4]

      -- Support multiple events as a table
      local event_list = {}
      for ev in string.gmatch(events, "[^,]+") do
        table.insert(event_list, ev)
      end

      vim.api.nvim_create_autocmd(event_list, {
        pattern = pattern,
        desc = desc,
        group = group_id,
        command = type(command) == "string" and command or nil,
        callback = type(command) == "function" and command or nil,
      })
    end
  end
end

M.nvim_create_augroups(autoCommands)
