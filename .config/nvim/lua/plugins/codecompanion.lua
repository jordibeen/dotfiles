local OPPER_URL = "https://api.opper.ai/v3/compat"
local OPPER_CHAT_URL = "/chat/completions"

local DEFAULT_MODEL = "inceptron/zai-org/GLM-5.3"
local MODEL_FLASH = "greenference/glm-5.3-flash"
local MODEL_BACKGROUND = "tensorx/qwen/qwen3.8-27b"

local OBSIDIAN = vim.env.OBSIDIAN_DIR and vim.fn.expand(vim.env.OBSIDIAN_DIR) or nil
local PROMPT_DIR = OBSIDIAN and OBSIDIAN .. "/Resources/Prompts"

local function load_prompt(name)
    if not PROMPT_DIR then return nil end
    local path = PROMPT_DIR .. "/" .. name .. ".md"
    local file = io.open(path, "r")
    if not file then
        vim.notify("[codecompanion] prompt not found: " .. path, vim.log.levels.WARN)
        return nil
    end
    local content = file:read("*a")
    file:close()
    return (content:gsub("^%-%-%-.-\r?\n%-%-%-\r?\n", "", 1))
end

local opper_work_models = {
    -- Open frontier
    ["inceptron/zai-org/GLM-5.3"] = { opts = { can_reason = true } },
    ["sference/kimi-k3"] = { opts = { can_reason = true } },

    -- Flash models
    ["greenference/glm-5.3-flash"] = { opts = { can_reason = true } },
    ["melious/deepseek-v4.1-flash"] = { opts = { can_reason = true } },
    ["tensorx/qwen/qwen3.8-27b"] = { opts = { can_reason = true } },

    -- Anthropic
    ["aws/claude-opus-5-5"] = { opts = { can_reason = true } },
    ["aws/claude-sonnet-5"] = { opts = { can_reason = true } },
    ["aws/claude-opus-4-8"] = { opts = { can_reason = true } },

    -- OpenAI
    ["azure:eu/gpt-6-sol"] = { opts = { can_reason = true } },
    ["azure:eu/gpt-6-luna"] = { opts = { can_reason = true } },
    ["azure/gpt-6-astra-global"] = { opts = { can_reason = true } },

    -- Google
    ["vertexai/gemini-3.6-flash-eu"] = { opts = { can_reason = true } },
    ["vertexai/gemini-3.7-flash-eu"] = { opts = { can_reason = true } },
    ["vertexai/gemini-3.8-flash-eu"] = { opts = { can_reason = true } },
    ["berget/gemma-4-31b-it"] = { opts = { can_reason = true } },
}

local opper_personal_models = {}
for k, v in pairs(opper_work_models) do
    opper_personal_models[k] = v
end
opper_personal_models["anthropic/claude-fable-5-1"] = { opts = { can_reason = true } }
opper_personal_models["anthropic/claude-fable-5"] = { opts = { can_reason = true } }

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
                                        ["claude-opus-5"] = {
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
                opper_personal = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        env = {
                            url = OPPER_URL,
                            chat_url = OPPER_CHAT_URL,
                            api_key = "OPPER_API_KEY_PERSONAL",
                        },
                        schema = {
                            model = {
                                default = DEFAULT_MODEL,
                                choices = opper_personal_models,
                            },
                        },
                    })
                end,
                opper_work = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        env = {
                            url = OPPER_URL,
                            chat_url = OPPER_CHAT_URL,
                            api_key = "OPPER_API_KEY_WORK",
                        },
                        schema = {
                            model = {
                                default = DEFAULT_MODEL,
                                choices = opper_work_models,
                            },
                        },
                    })
                end,
            },
            acp = {
                opencode = function()
                    return require("codecompanion.adapters").extend("opencode", {
                        defaults = {
                            session_config_options = {
                                model = "opper_work/" .. DEFAULT_MODEL,
                            },
                        },
                    })
                end,
                opts = {
                    show_presets = false
                },
            }
        },
        prompt_library = (function()
            if not OBSIDIAN then return {} end
            local lib = {}
            for _, path in ipairs(vim.fn.glob(PROMPT_DIR .. "/*.md", false, true)) do
                local name = vim.fn.fnamemodify(path, ":t:r")
                local prompt = load_prompt(name)
                lib[name] = {
                    strategy = "chat",
                    description = prompt,
                    opts = { short_name = name },
                    prompts = {
                        { role = "system", content = prompt },
                    },
                }
            end
            return lib
        end)(),
        interactions = {
            chat = {
                adapter = {
                    name = "opper_work",
                    model = DEFAULT_MODEL
                },
                roles = {
                    user = "🔥 " .. (vim.env.USER or "me"),
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
                tools = {
                    brain = {
                        path = false,
                        callback = function()
                            local memory = vim.deepcopy(require("codecompanion.interactions.chat.tools.builtin.memory"))
                            memory.schema = {
                                type = "function",
                                ["function"] = {
                                    name = "brain",
                                    description =
                                    "Read-only access to the user's Obsidian vault at /brain.",
                                    parameters = {
                                        type = "object",
                                        properties = {
                                            command = { type = "string", enum = { "view" } },
                                            path = { type = "string", description = "Absolute path under /brain." },
                                            view_range = { type = "array", items = { type = "integer" }, description = "Optional [start, end] lines, 1-indexed." },
                                        },
                                        required = { "command", "path" },
                                    },
                                },
                            }
                            memory.system_prompt = load_prompt("tools/brain")
                            memory.output.cmd_string = function(self) return self.args and self.args.path end
                            return memory
                        end,
                        opts = {
                            require_approval_before = function(tool) return tool.args.command ~= "view" end,
                            whitelist = { { path = OBSIDIAN, as = "/brain" } },
                        },
                    },
                },
                opts = {
                    system_prompt = "You are a helpful assistant.",
                }
            },
            inline = {
                adapter = {
                    name = "opper_work",
                    model = DEFAULT_MODEL,
                },
            },
            background = {
                adapter = {
                    name = "opper_work",
                    model = MODEL_BACKGROUND,
                },
            },
            cmd = {
                adapter = {
                    name = "opper_work",
                    model = MODEL_FLASH,
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
            log_level = "WARN",
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
                start_in_insert_mode = false,
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
                        adapter = "opper_personal",
                        model = MODEL_BACKGROUND,
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
        { "<C-a>",          "<cmd>CodeCompanionActions<cr>",               mode = { "n", "v" }, desc = "Actions" },
        { "<localleader>a", "<cmd>CodeCompanionChat Toggle<cr>",           mode = { "n", "v" }, desc = "Toggle Chat" },
        { "<localleader>c", "<cmd>CodeCompanionChat adapter=opencode<cr>", mode = { "n", "v" }, desc = "Start OpenCode session" },
        { "ga",             "<cmd>CodeCompanionChat Add<cr>",              mode = { "v" },      desc = "Add To Chat" },
        { "<leader>ccs",    "<cmd>CodeCompanionChatSave<cr>",              mode = { "n", "v" }, desc = "[C]ode [C]ompanion [S]ave chat" },

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
