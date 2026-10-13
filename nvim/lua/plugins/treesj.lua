return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    { '<space>m', function() require('treesj').toggle() end, desc = "Split/Join via autodetect" },
    { '<space>j', function() require('treesj').join() end,   desc = "Join" },
    { '<space>s', function() require('treesj').split() end,  desc = "Split" },
  },
  opts = { use_default_keymaps = false },
}
