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
      function() vim.hl.on_yank() end
    }
  }
}

require('utils.autocmds').nvim_create_augroups(autoCommands)
