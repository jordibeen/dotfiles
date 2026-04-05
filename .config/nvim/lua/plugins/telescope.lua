return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "junegunn/fzf",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown()
                }
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")
        end,
        keys = {
            { "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', desc = "Telescope Find Files" },
            { "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>',  desc = "Telescope Live Grep" },
            { "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>',    desc = "Telescope Find Buffers" },
            { "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>',  desc = "Telescope Help Tags" },
            { "<leader>fs", '<cmd>lua require("telescope.builtin").git_status()<cr>', desc = "Telescope Git Status" },

        }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    }
}
