return {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
        use_local_fs = true,
        enable_builtin = true,
    },
    keys = {
        {
            "<leader>ghi",
            "<cmd>Octo issue list<cr>",
            desc = "List GitHub Issues",
        },
        {
            "<leader>ghp",
            "<cmd>Octo pr list<cr>",
            desc = "List GitHub PRs",
        },
        {
            "<leader>ghd",
            "<cmd>Octo discussion list<cr>",
            desc = "List GitHub Discussions",
        },
        {
            "<leader>ghn",
            "<cmd>Octo notification list<cr>",
            desc = "List GitHub Notifications",
        },
        {
            "<leader>gho",
            "<cmd>Octo pr search is:pr is:open org:check-mobility<cr>",
            desc = "Search Check's PRs",
        },
        {
            "<leader>ghb",
            "<cmd>Octo pr browser<cr>",
            desc = "Open PR in browser",
        }
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function(_, opts)
        require("octo").setup(opts)

        local function mirror_mapping(key)
            return function()
                local m = vim.fn.maparg(key, "i", false, true)
                if m.callback then
                    m.callback(vim.api.nvim_get_current_buf())
                end
            end
        end

        local ll = vim.g.maplocalleader
        require("telescope").setup({
            defaults = {
                mappings = {
                    n = {
                        [ll .. "nr"] = mirror_mapping(ll .. "nr"),
                        [ll .. "nd"] = mirror_mapping(ll .. "nd"),
                        [ll .. "nu"] = mirror_mapping(ll .. "nu"),
                    }
                }
            }
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "TelescopePrompt",
            callback = function(args)
                local picker = require("telescope.actions.state").get_current_picker(args.buf)
                if picker and picker.prompt_title:match("Github Notifications") then
                    require("which-key").add({
                        { "<localleader>n",  group = "Notification", buffer = args.buf },
                        { "<localleader>nr", desc = "Mark as read",  buffer = args.buf },
                        { "<localleader>nd", desc = "Mark as done",  buffer = args.buf },
                        { "<localleader>nu", desc = "Unsubscribe",   buffer = args.buf },
                    })
                end
            end,
        })
    end
}
