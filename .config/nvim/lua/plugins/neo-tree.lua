return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        buffers = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = false,
            },
        },
        filesystem = {
            filtered_items = {
                always_show = {
                    ".gitignore",
                    ".env",
                    ".github",
                    ".test.yaml",
                    ".production.yaml",
                    "terraform.tfvars",
                    ".cargo",
                }
            }
        },
        event_handlers = {
            {
                event = "file_opened",
                handler = function()
                    vim.cmd("Neotree close")
                end
            },
        },
        window = {
            mappings = {
                ["<bs>"] = "",
                ["P"] = {
                    "toggle_preview",
                    config = {
                        use_float = false,
                        use_image_nvim = true
                    }
                }
            },
        },
    }
}
