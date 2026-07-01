return {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
        { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",                mode = "n" },
        { "<C-j>", "<cmd>TmuxNavigateDown<cr>",                mode = "n" },
        { "<C-k>", "<cmd>TmuxNavigateUp<cr>",                  mode = "n" },
        { "<C-l>", "<cmd>TmuxNavigateRight<cr>",               mode = "n" },
        { "<C-h>", function() vim.cmd("TmuxNavigateLeft") end, mode = "t" },
        { "<C-j>", function() vim.cmd("TmuxNavigateDown") end, mode = "t" },
        { "<C-k>", function() vim.cmd("TmuxNavigateUp") end,   mode = "t" },
        { "<C-l>", function() vim.cmd("TmuxNavigateLeft") end, mode = "t" },
    },
    init = function()
        vim.g.tmux_navigator_no_mappings = 1
    end,
}
