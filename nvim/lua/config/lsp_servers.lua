-- see :help vim.lsp.Config for available lsp config options

return {
  clangd = {},
  gopls = {},
  pyright = {},
  html = {},
  cssls = {},
  jdtls = {},
  ts_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}
