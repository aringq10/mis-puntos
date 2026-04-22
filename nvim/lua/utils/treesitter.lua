local M = {}

local function show_in_buffer(title, items)
  table.sort(items)
  vim.cmd('vnew')
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.api.nvim_buf_set_name(buf, title)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, items)
  vim.bo[buf].modifiable = false
end

local function auto_install(ts)
  local tried = {}
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local ft = args.match
      if ft == "" then return end

      local lang = vim.treesitter.language.get_lang(ft) or ft
      if tried[lang] then
        pcall(vim.treesitter.start)
        return
      end

      if vim.tbl_contains(ts.get_installed(), lang) then
        pcall(vim.treesitter.start)
        return
      end

      if not vim.tbl_contains(ts.get_available(), lang) then
        tried[lang] = true
        return
      end

      tried[lang] = true
      ts.install({ lang }):await(function()
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            vim.api.nvim_buf_call(args.buf, function()
              pcall(vim.treesitter.start)
            end)
          end
        end)
      end)
    end,
  })
end

function M.setup()
  local ts = require('nvim-treesitter')

  auto_install(ts)

  vim.api.nvim_create_user_command("TSListInstalled", function()
    show_in_buffer("TS Installed", ts.get_installed())
  end, { desc = "List installed treesitter parsers" })

  vim.api.nvim_create_user_command("TSListAvailable", function()
    show_in_buffer("TS Available", ts.get_available())
  end, { desc = "List all available treesitter parsers" })
end

return M
