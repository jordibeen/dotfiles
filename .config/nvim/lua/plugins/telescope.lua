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
            },
            defaults = {
                mappings = {
                    i = {
                        ["<S-D>"] = function(prompt_bufnr)
                            for _ = 1, 10 do require('telescope.actions').move_selection_next(prompt_bufnr) end
                        end,
                        ["<S-U>"] = function(prompt_bufnr)
                            for _ = 1, 10 do require('telescope.actions').move_selection_previous(prompt_bufnr) end
                        end,
                    },
                    n = {
                        ["<S-D>"] = function(prompt_bufnr)
                            for _ = 1, 10 do require('telescope.actions').move_selection_next(prompt_bufnr) end
                        end,
                        ["<S-U>"] = function(prompt_bufnr)
                            for _ = 1, 10 do require('telescope.actions').move_selection_previous(prompt_bufnr) end
                        end,
                    },
                }
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("ui-select")
        end,
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
            { "<leader>fG", "<cmd>Telescope grep_string<cr>",               desc = "Grep Word Under Cursor" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Help Tags" },
            { "<leader>fF", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find in Buffer" },
            { "<leader>fn", "<cmd>Telescope resume<cr>",                    desc = "Resume Last Picker" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>",                   desc = "Keymaps" },
            { "<leader>fm", "<cmd>Telescope marks<cr>",                     desc = "Marks" },
            { "<leader>fr", "<cmd>Telescope registers<cr>",                 desc = "Registers" },
            { "<leader>fo", "<cmd>Telescope vim_options<cr>",               desc = "Vim Options" },
            { "<leader>f/", "<cmd>Telescope search_history<cr>",            desc = "Search History" },
            { "<leader>f:", "<cmd>Telescope command_history<cr>",           desc = "Command History" },
            { "<leader>gs", "<cmd>Telescope git_status<cr>",                desc = "Git Status" },
            { "<leader>gc", "<cmd>Telescope git_commits<cr>",               desc = "Git Commits" },
            { "<leader>gb", "<cmd>Telescope git_branches<cr>",              desc = "Git Branches" },
        }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    }
}
