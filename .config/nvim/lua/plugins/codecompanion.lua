return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/codecompanion-history.nvim",
    },
    lazy = false,
    opts = {
        adapters = {
            http = {
                opts = {
                    show_presets = false
                },
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        env = {
                            api_key = "ANTHROPIC_API_KEY",
                        },
                        schema = {
                            model = {
                                default = "claude-sonnet-5",
                                choices = function()
                                    return {
                                        ["claude-sonnet-5"] = {
                                            opts = {
                                                extended_thinking = {
                                                    default = false,
                                                },
                                            },
                                        },
                                        ["claude-opus-4-8"] = {
                                            opts = {
                                                extended_thinking = {
                                                    default = false,
                                                },
                                            },
                                        },
                                    }
                                end,
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
                                default = "evroc/zai-org/GLM-5.2",
                                choices = {
                                    ["evroc/zai-org/GLM-5.2"] = { opts = { can_reason = true } },
                                    ["azure/gpt-5.5"] = { opts = { can_reason = true } },
                                    ["geodd:no/gpt-oss-120b"] = { opts = { can_reason = true } },
                                    ["azure/claude-sonnet-4-6"] = { opts = { can_reason = true } },
                                    ["azure/claude-haiku-4-5"] = {},
                                    ["aws/claude-opus-4-8"] = { opts = { can_reason = true } },
                                    ["azure/gpt-5.4-mini"] = {},
                                    ["azure/gpt-5.4-nano"] = {},
                                },
                            },
                        },
                    })
                end,
            },
            acp = {
                opencode = "opencode",
                opts = {
                    show_presets = false
                },
            }
        },
        interactions = {
            chat = {
                adapter = {
                    name = "opper",
                    model = "evroc/zai-org/GLM-5.2",
                },
                roles = {
                    user = "🔥 jb",
                    llm = function(adapter)
                        if adapter.type == "http" then
                            return string.format("💬 %s (%s)", adapter.model.name, adapter.name)
                        else
                            return string.format("🤖 %s", adapter.name)
                        end
                    end,
                },
                keymaps = {
                    debug = {
                        modes = { n = "gz" },
                    },
                    clear = {
                        modes = { n = "gq" },
                    },
                },
                opts = {
                    system_prompt = "You are a helpful assistant.",
                }
            },
            inline = {
                adapter = {
                    name = "opper",
                    model = "evroc/zai-org/GLM-5.2",
                },
            },
            background = {
                adapter = {
                    adapter = "opper",
                    model = "azure/gpt-5.4-nano",
                },
            },
            cmd = {
                adapter = {
                    name = "opencode",
                    model = "evroc/zai-org/GLM-5.2",
                },
            },
            cli = {
                agent = "opencode",
                agents = {
                    opencode = {
                        cmd = "opencode",
                        description = "Opencode CLI",
                        provider = "terminal",
                    },
                },
                opts = {
                    auto_insert = true,
                },

            }
        },
        opts = {
            log_level = "DEBUG",
        },
        display = {
            action_palette = {
                opts = {
                    show_presets = false
                }
            },
            chat = {
                window = {
                    buflisted = true,
                },
                intro_message = "",
                start_in_insert_mode = true,
                show_settings = false,
            },
        },
        extensions = {
            history = {
                enabled = true,
                delete_on_clearing_chat = true,
                opts = {
                    dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                    title_generation_opts = {
                        adapter = "opper",
                        model = "azure/gpt-5.4-nano",
                        refresh_every_n_prompts = 0,
                        max_refreshes = 3,
                        format_title = function(title)
                            local timestamp = os.date("%Y%m%dT%H%M%S")
                            return string.format("%s - %s", timestamp, title)
                        end
                    },
                }
            }
        }
    },
    keys = {
        { "<C-a>",         "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "Actions" },
        { "<localleader>", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
        { "ga",            "<cmd>CodeCompanionChat Add<cr>",    mode = { "v" },      desc = "Add To Chat" },
        { "<leader>ccn",   "<cmd>CodeCompanionChat<cr>",        mode = { "n", "v" }, desc = "[C]ode [C]ompanion [N]ew" },
        { "<leader>ccs",   "<cmd>CodeCompanionChatSave<cr>",    mode = { "n", "v" }, desc = "[C]ode [C]ompanion [S]ave to Obsidian" },

    },
    config = function(_, opts)
        require("codecompanion").setup(opts)
        vim.cmd([[cab cc CodeCompanion]])

        local save_chat = function(bufnr)
            local dir = vim.fn.expand(os.getenv("CODECOMPANION_CHATS_DIR"))
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local content = table.concat(lines, "\n")
            local timestamp = os.date("%Y%m%dT%H%M%S")
            local path = string.format("%s/%s.md", dir, timestamp)
            local f, open_err = io.open(path, "w")
            if not f then
                vim.notify("[CodeCompanion] Failed to open " .. path .. ": " .. tostring(open_err), vim.log.levels.ERROR)
                return
            end
            f:write(content)
            f:close()
            vim.notify("[CodeCompanion] Chat saved to " .. path, vim.log.levels.INFO)
        end

        vim.api.nvim_create_user_command("CodeCompanionChatSave", function()
            local chat = require("codecompanion").buf_get_chat(0)
            save_chat(chat and chat.bufnr or 0)
        end, { desc = "Save the current CodeCompanion chat to CODECOMPANION_CHATS_DIR" })
    end
}
