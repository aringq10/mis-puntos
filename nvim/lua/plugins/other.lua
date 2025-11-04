return {
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-path" },
    { "windwp/nvim-autopairs", config = true },
    { "folke/tokyonight.nvim"},
    {
        "preservim/nerdtree",
        lazy = false,
        keys = {
            { "<F3>", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" }
    	}
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
            handler_opts = {
                border = "rounded"
            }
        },
    }
}
