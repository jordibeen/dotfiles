return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {
        display = {
            action_palette = {
                opts = {
                    show_preset_prompts = false }
            }
        },
        adapters = {
            http = {
                opts = {
                    show_defaults = false
                },
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        env = {
                            api_key = "ANTHROPIC_API_KEY",
                        },
                        schema = {
                            model = {
                                choices = {
                                    ["claude-sonnet-5"] = { opts = { can_reason = true } },
                                },
                            },
                        },
                    })
                end,
                opper = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        env = {
                            url = "https://api.opper.ai/v3/compat",
                            chat_url = "/chat/completions",
                            api_key = "OPPER_API_KEY",
                        },
                        schema = {
                            model = {
                                choices = {
                                    ["nebius/zai-org/GLM-5.2"] = { opts = { can_reason = true } },
                                    "azure/claude-haiku-4-5",
                                    "aws/claude-opus-4-8",
                                    "azure/claude-sonnet-4-6",
                                    "geodd:no/gpt-oss-120b",
                                    "azure/gpt-5.5",
                                    "azure/gpt-5.4-mini",
                                },
                            },
                        },
                    })
                end,
            },
        },
        interactions = {
            chat = {
                render_headers = true,
                header_template = "## test",
                adapter = {
                    name = "opper",
                    model = "nebius/zai-org/GLM-5.2",
                },
            },
            inline = {
                adapter = {
                    name = "opper",
                    model = "nebius/zai-org/GLM-5.2",
                },
            },
            cmd = {
                adapter = {
                    name = "opencode",
                    model = "nebius/zai-org/GLM-5.2",
                },
            },
            background = {
                adapter = {
                    name = "opper",
                    model = "azure/claude-haiku-4-5",
                },
            },
            cli = {
                agent = "opencode",
                agents = {
                    opencode = {
                        cmd = "opencode",
                        args = {},
                        description = "Opencode CLI",
                        provider = "terminal",
                    },
                },

            }
        },
        opts = {
            log_level = "DEBUG",
        },
    },
    keys = {
        { "<C-a>",         "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "Actions" },
        { "<LocalLeader>", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
        { "ga",            "<cmd>CodeCompanionChat Add<cr>",    mode = { "v" },      desc = "Add To Chat" },
    },
    config = function(_, opts)
        require("codecompanion").setup(opts)
        vim.cmd([[cab cc CodeCompanion]])
    end
}
