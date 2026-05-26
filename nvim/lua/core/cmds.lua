vim.api.nvim_create_user_command("HiStatus", function()
    -- Treesitter highlighter attached?
    local ts_on = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil

    -- Regex syntax loaded? (set by syntax/<ft>.vim when it ran)
    local syn_on = vim.b.current_syntax ~= nil

    print("Syntax highlighting status:")
    print(string.format('treesitter: %s, regex syntax: %s', ts_on, syn_on))
end, { desc = "Print whether TS or regex syntax highlighting is on" })

vim.api.nvim_create_user_command("ToggleRelNum", function()
    vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relativenumber" })

vim.api.nvim_create_user_command('PrintRtp', function()
    for _, p in ipairs(vim.opt.runtimepath:get()) do print(p) end
end, { desc = "Print runtimepath entries" })
