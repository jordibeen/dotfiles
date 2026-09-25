return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "‾" },
            changedelete = { text = "▎" },
        },
        current_line_blame = true,
        current_line_blame_opts = {
            delay = 300,
            virt_text_pos = "right_align",
        },
        word_diff = false,
    },
    config = function(_, opts)
        local gitsigns = require('gitsigns')
        gitsigns.setup(opts)

        require("which-key").add({
            {
                mode = { "n" },
                nowait = true,
                remap = false,

                { "gs",         group = "gitsigns" },
                { "gsh",        gitsigns.stage_hunk,                                       desc = "Stage hunk" },
                { "gsr",        gitsigns.reset_hunk,                                       desc = "Reset hunk" },
                { "gsu",        gitsigns.undo_stage_hunk,                                  desc = "Undo stage" },
                { "gsp",        gitsigns.preview_hunk,                                     desc = "Preview hunk" },
                { "gsd",        gitsigns.diffthis,                                         desc = "Diff (index vs working)" },
                { "gsD",        function() gitsigns.diffthis("~") end,                     desc = "Diff against HEAD" },
                { "gsj",        function() gitsigns.nav_hunk("next", { wrap = true }) end, desc = "Next hunk" },
                { "gsk",        function() gitsigns.nav_hunk("prev", { wrap = true }) end, desc = "Prev hunk" },
                { "gsb",        gitsigns.stage_buffer,                                     desc = "Stage buffer" },
                { "gsq",        gitsigns.setqflist,                                        desc = "Hunks to quickfix" },
                { "gsQ",        function() gitsigns.setqflist('all') end,                  desc = "All hunks to quickfix" },
                { "<leader>tb", gitsigns.toggle_current_line_blame,                        desc = "Toggle current line blame" },
                { "<leader>tw", gitsigns.toggle_word_diff,                                 desc = "Toggle word diff" },
                { "<leader>td", gitsigns.toggle_deleted,                                   desc = "Toggle deleted lines as virtual text" },
            },
            {
                mode = { "v" },
                nowait = true,
                remap = false,

                { "gsh", function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = "Stage selection" },
                { "gsr", function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, desc = "Reset selection" },
            }
        })
    end
}
