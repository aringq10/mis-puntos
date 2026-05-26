return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  keys = {
    { "<leader>ts", function() require('treesj').toggle() end, desc = "TreeSJ Toggle" },
  },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
    })
  end,
}
