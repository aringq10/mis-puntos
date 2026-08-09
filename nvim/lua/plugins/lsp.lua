-- https://github.com/neovim/nvim-lspconfig

-- nvim-lspconfig is a collection of default configs(nvim-lspconfig/lsp/) for
-- different language servers. Besides that it offers a framework for enabling
-- LSs with the default config + user passed config. Though this framework has
-- been replaced with vim.lsp.config() + vim.lsp.enable() (see :help lspconfig-nvim-0.11),
-- therefore nvim-lspconfig offers default configs and commands like
-- LspInfo, LspStart etc. (nvim-lspconfig/plugin/lspconfig.lua)

return {
  { -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- mason - tool downloader
      -- mason-tool-installer - automatically installs passed tools using mason
      -- mason-lspconfig - maps LSP server names between nvim-lspconfig and Mason package names.
      { 'mason-org/mason.nvim', opts = {} },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'mason-org/mason-lspconfig.nvim',

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local builtin = require("telescope.builtin")
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = args.buf, desc = "LSP: " .. desc })
          end

          map("grd", builtin.lsp_definitions,               "Definition")
          map("grr", builtin.lsp_references,                "References")
          map("gri", builtin.lsp_implementations,           "Implementation")
          map("grt", builtin.lsp_type_definitions,          "Type Definition")
          map("grs", builtin.lsp_document_symbols,          "Document Symbols")
          map("grw", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
          map("grci", builtin.lsp_incoming_calls,           "Incoming Calls")
          map("grco", builtin.lsp_outgoing_calls,           "Outgoing Calls")
          map("grD", vim.lsp.buf.declaration,               "Declaration")
          map("grn", vim.lsp.buf.rename,                    "Rename")
          map("gra", vim.lsp.buf.code_action,               "Code Action")
          map("K",   function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover Docs")
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN]  = '󰀪 ',
            [vim.diagnostic.severity.INFO]  = '󰋽 ',
            [vim.diagnostic.severity.HINT]  = '󰌶 ',
          },
        } or {},
        virtual_text = true
      }

      local servers = require("config.lsp_servers")

      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })

      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
      require('mason-lspconfig').setup({ automatic_enable = false })

      for name, opts in pairs(servers) do
        vim.lsp.config(name, opts)
        vim.lsp.enable(name)
      end
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      enabled = true,
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "nvim-lspconfig" },
      },
    },
  },
}
