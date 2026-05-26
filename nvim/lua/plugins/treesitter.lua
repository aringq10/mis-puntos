-- Syntax highlighting, indentation, folding

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    keys = {
      -- "a" - toggle display of anonymous nodes, "I" - node source lang,
      -- "o" - query editor, <Enter> - jump to node, folding also works.
      { "<leader>ttp", vim.show_pos, desc = "Inspect Pos" },
      { "<leader>ttt", function() vim.treesitter.inspect_tree() vim.api.nvim_input("I") end, desc = "Inspect Tree" },
    },
    config = function()
      require('utils.treesitter').setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true

      -- Or, disable per filetype (add as you like)
      -- vim.g.no_python_maps = true
      -- vim.g.no_ruby_maps = true
      -- vim.g.no_rust_maps = true
      -- vim.g.no_go_maps = true
    end,
    config = function()
      require('utils.treesitter_textobjects').setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {}
  },
  { -- complete/rename html tags
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
