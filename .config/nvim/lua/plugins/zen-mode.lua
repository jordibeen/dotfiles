return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            backdrop = 0.5,
            width = 0.65,
            options = {
                number = false,
                relativenumber = false,
                cursorline = false,
                cursorcolumn = false,
                list = false,
                wrap = true,
                linebreak = true,
            },
        },
    },
    config = function(_, opts)
        require("zen-mode").setup(opts)
        require("which-key").add({
            {
                mode = { "n" },
                nowait = true,
                remap = false,
                { "<leader>Z", "<cmd>ZenMode<cr>", desc = "Toggle [Z]enmode" }
            }

        })
    end
}
