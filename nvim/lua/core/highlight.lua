local function set_transparent_floats()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })

  for _, name in ipairs({ "NormalFloat", "FloatBorder", "FloatTitle" }) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    vim.api.nvim_set_hl(0, name, vim.tbl_extend("force", { fg = normal.fg }, hl, { bg = "NONE", ctermbg = "NONE" }))
  end

  -- lazy maps Normal -> LazyNormal in its window, so it needs its own entry
  vim.api.nvim_set_hl(0, "LazyNormal", { fg = normal.fg, bg = "NONE", ctermbg = "NONE" })

  vim.api.nvim_set_hl(0, "YaziFloatBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "WhichKeyNormal", { link = "NormalFloat" })
end

local function set_custom_hl()
  set_transparent_floats()
end

set_custom_hl()

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_custom_hl })
