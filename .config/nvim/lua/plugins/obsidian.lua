return {
    "obsidian-nvim/obsidian.nvim",
    opts = {
        legacy_commands = false,
        workspaces = {
            {
                name = "obsidian",
                path = os.getenv("OBSIDIAN_DIR"),
            }
        },
        statusline = {
            enabled = false,
        },
        footer = {
            enabled = false,
        },
        ui = {
            enable = false
        },
        frontmatter = {
            enabled = true,
            func = function(note)
                local out = {
                    created = os.date("%Y-%m-%dT%H:%M"),
                    type = "note",
                    tags = note.tags or {},
                }

                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end

                return out
            end,
            sort = { "created", "tags", "type" },
        },
    },
    config = function(_, opts)
        require("obsidian").setup(opts)

        local telescope = require('telescope.builtin')
        require("which-key").add({

            {
                mode = { "n" },
                nowait = true,
                remap = false,
                { "<C-o>on", "<cmd>Obsidian new<cr>",                                                  desc = "Obsidian [O]pen [N]ew" },
                { "<C-o>ot", "<cmd>Obsidian today<cr>",                                                desc = "Obsidian [O]pen [T]oday" },
                { "<C-o>s",  "<cmd>Obsidian open<cr>",                                                 desc = "Obsidian [S]how" },
                { "<C-o>fn", function() telescope.find_files({ cwd = os.getenv("OBSIDIAN_DIR") }) end, desc = "Obsidian [F]ind [N]ote" },
                { "<C-o>fg", function() telescope.live_grep({ cwd = os.getenv("OBSIDIAN_DIR") }) end,  desc = "Obsidian [F]ind [G]rep" },
            }

        })
    end
}
