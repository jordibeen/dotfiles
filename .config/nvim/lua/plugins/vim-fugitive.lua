return {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
        { "<leader>gos", "<cmd>Git<cr>",         desc = "Fugitive status" },
        { "<leader>gov", "<cmd>Gvdiffsplit<cr>", desc = "Fugitive diff split" },

    }
}
