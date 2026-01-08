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
        event_handlers = {
            {
                event = "file_opened",
                handler = function()
                    vim.cmd("Neotree close")
                end
            },
        },
        commands = {
            trash = function(state)
                local inputs = require("neo-tree.ui.inputs")
                local path = state.tree:get_node().path
                local msg = "Are you sure you want to trash " .. path .. "?"
                inputs.confirm(msg, function(confirmed)
                    if confirmed then
                        vim.fn.system({ "mv", vim.fn.fnameescape(path), os.getenv("HOME") .. "/.Trash/" })
                        require("neo-tree.sources.manager").refresh(state.name)
                    end
                end)
            end,

            trash_visual = function(state, selected_nodes)
                local inputs = require("neo-tree.ui.inputs")
                local msg = "Are you sure you want to trash " .. #selected_nodes .. " items?"
                inputs.confirm(msg, function(confirmed)
                    if confirmed then
                        for _, node in ipairs(selected_nodes) do
                            vim.fn.system({ "mv", vim.fn.fnameescape(node.path), os.getenv("HOME") .. "/.Trash/" })
                        end
                        require("neo-tree.sources.manager").refresh(state.name)
                    end
                end)
            end,
        },
        window = {
            mappings = {
                ["P"] = {
                    "toggle_preview",
                    config = {
                        use_float = false,
                        use_image_nvim = true
                    }
                },
                ["t"] = "trash",
            },
        },
    }
}
