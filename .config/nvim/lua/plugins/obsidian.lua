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
        templates = {
            folder = "Templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },
        daily_notes = {
            folder = "Dailies",
            date_format = "YYYY/MM-MMMM/YYYY-MM-DD",
            template = "Daily",
        },
        note_id_func = function(title)
            return title or tostring(os.time())
        end,
        statusline = {
            enabled = false,
        },
        footer = {
            enabled = false,
        },
        ui = {
            enable = false,
        },
        frontmatter = {
            enabled = false,
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
                { "<leader>on", "<cmd>Obsidian new<cr>",                                                  desc = "Obsidian Open [N]ew" },
                { "<leader>ot", "<cmd>Obsidian today<cr>",                                                desc = "Obsidian Open [T]oday" },
                { "<leader>oy", "<cmd>Obsidian yesterday<cr>",                                            desc = "Obsidian Open [Y]esterday" },
                { "<leader>od", "<cmd>Obsidian dailies<cr>",                                              desc = "Obsidian Find [D]aily" },
                { "<leader>os", "<cmd>Obsidian open<cr>",                                                 desc = "Obsidian [S]how" },
                { "<leader>of", function() telescope.find_files({ cwd = os.getenv("OBSIDIAN_DIR") }) end, desc = "Obsidian [F]ind Note" },
                { "<leader>og", function() telescope.live_grep({ cwd = os.getenv("OBSIDIAN_DIR") }) end,  desc = "Obsidian Find [G]rep" },
                { "<leader>ob", "<cmd>Obsidian backlinks<cr>",                                            desc = "Obsidian [B]acklinks" },
                { "<leader>or", "<cmd>Obsidian rename<cr>",                                               desc = "Obsidian [R]ename" },
                { "<leader>oT", "<cmd>Obsidian tags<cr>",                                                 desc = "Obsidian [T]ags" },
            }

        })
    end
}
