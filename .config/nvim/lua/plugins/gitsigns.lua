return {
    "lewis6991/gitsigns.nvim",
    opts = {
        current_line_blame = true
    },
    config = function(_, opts)
        local gitsigns = require('gitsigns')
        gitsigns.setup(opts)
        require("which-key").add({
            {
                mode = { "n" },
                nowait = true,
                remap = false,

                { "<leader>hs", gitsigns.stage_hunk,                                 desc = "Stage hunk" },
                { "<leader>hr", gitsigns.reset_hunk,                                 desc = "Reset hunk" },
                { "<leader>hS", gitsigns.stage_buffer,                               desc = "Stage buffer" },
                { "<leader>hR", gitsigns.reset_buffer,                               desc = "Reset buffer" },
                { "<leader>hp", gitsigns.preview_hunk,                               desc = "Preview hunk" },
                { "<leader>hi", gitsigns.preview_hunk_inline,                        desc = "Preview hunk inline" },
                { "<leader>hb", function() gitsigns.blame_line({ full = true }) end, desc = "Gitsigns blame line full" },
                { "<leader>hd", gitsigns.diffthis,                                   desc = "Gitsigns diff line" },
                { "<leader>hD", function() gitsigns.diffthis("~") end,               desc = "Gitsigns diff file" },
                { "<leader>hQ", function() gitsigns.setqflist('all') end,            desc = "Set all to quickfix list" },
                { "<leader>hq", gitsigns.setqflist,                                  desc = "Set to quickfix list" },
                { "<leader>tb", gitsigns.toggle_current_line_blame,                  desc = "Toggle current line blame" },
                { "<leader>tw", gitsigns.toggle_word_diff,                           desc = "Toggle word diff" },
            },
            {
                mode = { "v" },
                nowait = true,
                remap = false,

                { "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = "Stage hunk" },
                { "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = "Reset hunk" },
            },
        })
    end
}
