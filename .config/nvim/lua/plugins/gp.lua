return {
    "robitx/gp.nvim",
    -- dir = "~/jordaye/gp.nvim",
    -- name = "gp.nvim",
    config = function()
        local prompts = {
            default = "You are a general AI assistant",
            ticket_creator =
            "You are an amazing assistant that helps with creating JIRA tickets for a software engineering tool. The title should not be a user story but rather a task that needs to be done. The description is in markdown and contains information for the ticket assignee to complete the ticket, it must always contain a definition of done. If the definition of done is unclear, ask the user for clarification on when the ticket can be considered done.\nThe ticket only contains a title and a description. Information regarding estimation, urgency or difficulty will be decided on later. All information regarding the ticket must be put in the ticket description, this description can contain multiple paragraphs and is formatted in markdown.\nAlways return the ticket in the following format:\n# [ticket title here]\n## Ticket Description\n[ticket description here]",
            docstring_creator =
            "You generate docstrings for functions that are passed to you.\nAnalyze the function for which language is used, and based on the language, generate a docstring based on that language's industry leading docstring format.\nIn case of Python, make sure to use Google Style.\nKeep it concise, returning at least a brief summary of the function, the arguments that can be passed, the return type and the exceptions it can raise.\nRespond with just the dosctring."
        }
        local conf = {
            default_chat_agent = "qwen3",
            default_command_agent = "qwen2.5-coder",

            providers = {
                openai = {
                    disable = false,
                    chat = true,
                    command = true,
                    endpoint = "https://api.openai.com/v1/chat/completions",
                    secret = os.getenv("OPENAI_API_KEY"),
                },
                ollama = {
                    disable = false,
                    chat = true,
                    command = true,
                    endpoint = "http://localhost:11434/api/chat",
                },
                anthropic = {
                    disable = false,
                    chat = true,
                    command = true,
                    endpoint = "https://api.anthropic.com/v1/messages",
                    secret = os.getenv("ANTHROPIC_API_KEY"),
                },
            },

            agents = {
                {
                    disable = false,
                    name = "gpt-5",
                    provider = "openai",
                    chat = true,
                    command = true,
                    model = {
                        model = "gpt-5-2025-08-07",
                        temperature = 0.8,
                    },
                    system_prompt = prompts["default"],
                },
                {
                    disable = false,
                    name = "claude-sonnet",
                    provider = "anthropic",
                    chat = true,
                    command = true,
                    model = {
                        model = "claude-sonnet-4-20250514",
                        temperature = 0.8,
                    },
                    system_prompt = prompts["default"],
                },
                {
                    disable = false,
                    name = "claude-sonnet-thinking",
                    provider = "anthropic",
                    chat = true,
                    command = true,
                    model = {
                        model = "claude-sonnet-4-20250514",
                        max_tokens = 8192,
                        thinking_budget = 4096,
                    },
                    system_prompt = prompts["default"],
                },
                {
                    disable = false,
                    name = "claude-opus",
                    provider = "anthropic",
                    chat = true,
                    command = true,
                    model = {
                        model = "claude-opus-4-1-20250805",
                        temperature = 0.8,
                    },
                    system_prompt = prompts["default"],
                },
                {
                    disable = false,
                    name = "claude-opus-thinking",
                    provider = "anthropic",
                    chat = true,
                    command = true,
                    model = {
                        model = "claude-opus-4-1-20250805",
                        max_tokens = 8192,
                        thinking_budget = 4096,
                    },
                    system_prompt = prompts["default"],
                },
                {
                    disable = false,
                    name = "gemma3",
                    provider = "ollama",
                    chat = true,
                    command = true,
                    model = {
                        temperature = 0.6,
                        model = "gemma3:4b",
                    },
                    system_prompt = prompts["default"],
                },
                {
                    disable = false,
                    name = "ticket-creator",
                    provider = "ollama",
                    chat = true,
                    command = false,
                    model = {
                        temperature = 0.2,
                        model = "qwen3:8b",
                        think = false,
                    },
                    system_prompt = prompts["ticket_creator"],
                },
                {
                    disable = false,
                    name = "docstring-creator",
                    provider = "ollama",
                    chat = true,
                    command = false,
                    model = {
                        temperature = 0.2,
                        model = "qwen3:8b",
                        think = false,
                    },
                    system_prompt = prompts["docstring_creator"],
                },
                {
                    disable = false,
                    name = "qwen2.5-coder",
                    provider = "ollama",
                    chat = true,
                    command = true,
                    model = {
                        model = "qwen2.5-coder:latest",
                        temperature = 0.6
                    },
                    system_prompt = prompts["default"],
                },
                {
                    disable = false,
                    name = "qwen3",
                    provider = "ollama",
                    chat = true,
                    command = true,
                    model = {
                        model = "qwen3:8b",
                        think = false
                    },
                    system_prompt = prompts["default"],
                },
                {
                    disable = false,
                    name = "qwen3-thinking",
                    provider = "ollama",
                    chat = true,
                    command = false,
                    model = {
                        model = "qwen3:8b",
                    },
                    system_prompt = prompts["default"],
                },
                { name = "ChatGPT4o",                    disable = true, },
                { name = "ChatGPT-o3-mini",              disable = true, },
                { name = "ChatGPT4o-mini",               disable = true, },
                { name = "ChatCopilot",                  disable = true, },
                { name = "ChatGemini",                   disable = true, },
                { name = "ChatPerplexityLlama3.1-8B",    disable = true, },
                { name = "ChatClaude-3-7-Sonnet",        disable = true, },
                { name = "ChatClaude-3-5-Haiku",         disable = true, },
                { name = "ChatClaude-Sonnet-4-Thinking", disable = true, },
                { name = "ChatOllamaLlama3.1-8B",        disable = true, },
                { name = "CodeOllamaLlama3.1-8B",        disable = true, },
                { name = "ChatQwen3-8B",                 disable = true, },
                { name = "ChatLMStudio",                 disable = true, },
                { name = "CodeGPT4o",                    disable = true, },
                { name = "CodeGPT-o3-mini",              disable = true, },
                { name = "CodeGPT4o-mini",               disable = true, },
                { name = "CodeCopilot",                  disable = true, },
                { name = "CodeGemini",                   disable = true, },
                { name = "CodePerplexityLlama3",         disable = true, },
                { name = "CodeClaude-3-7-Sonnet",        disable = true, },
                { name = "CodeClaude-3-5-Haiku",         disable = true, },
                { name = "CodeOllamaLlama3.1-8B",        disable = true, },
                { name = "CodeOllamaLlama3.1-8B",        disable = true, },
            },
            whisper = { disable = true, },
            image = { disable = true, },

            chat_dir = vim.fn.expand(os.getenv("GP_CHATS_DIR")),
            state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/persisted",
            log_file = vim.fn.stdpath("log"):gsub("/$", "") .. "/gp.nvim.log",
            log_sensitive = false,
            chat_user_prefix = "🔥:",
            chat_assistant_prefix = { "🤖:", "[{{agent}}]" },
            chat_template = require("gp.defaults").short_chat_template,
            chat_topic_gen_prompt = "Summarize the topic of our conversation above"
                .. " in two or three words. Respond only with those words.",
            chat_confirm_delete = true,
            chat_conceal_model_params = false,
            chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
            chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
            chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
            chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },
            chat_finder_pattern = "topic ",
            chat_finder_mappings = {
                delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-d>" },
            },
            chat_free_cursor = true,
            chat_prompt_buf_type = false,
            toggle_target = "vsplit",
            command_prompt_prefix_template = "🤖 {{agent}} ~ ",
            command_auto_select_response = true,

            hooks = {
                -- GpInspectPlugin provides a detailed inspection of the plugin state
                InspectPlugin = function(plugin, params)
                    local bufnr = vim.api.nvim_create_buf(false, true)
                    local copy = vim.deepcopy(plugin)
                    local key = copy.config.openai_api_key or ""
                    copy.config.openai_api_key = key:sub(1, 3) .. string.rep("*", #key - 6) .. key:sub(-3)
                    local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(copy))
                    local params_info = string.format("Command params:\n%s", vim.inspect(params))
                    local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
                    vim.api.nvim_win_set_buf(0, bufnr)
                end,

                -- GpInspectLog for checking the log file
                InspectLog = function(plugin, params)
                    local log_file = plugin.config.log_file
                    local buffer = plugin.helpers.get_buffer(log_file)
                    if not buffer then
                        vim.cmd("e " .. log_file)
                    else
                        vim.cmd("buffer " .. buffer)
                    end
                end,

                -- GpImplement rewrites the provided selection/range based on comments in it
                Implement = function(gp, params)
                    local template = "Having following from {{filename}}:\n\n"
                        .. "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Please rewrite this according to the contained instructions."
                        .. "\n\nRespond exclusively with the snippet that should replace the selection above."

                    local agent = gp.get_command_agent()
                    gp.logger.info("Implementing selection with agent: " .. agent.name)

                    gp.Prompt(
                        params,
                        gp.Target.rewrite,
                        agent,
                        template,
                        nil, -- command will run directly without any prompting for user input
                        nil  -- no predefined instructions (e.g. speech-to-text from Whisper)
                    )
                end,

                CodeReview = function(gp, params)
                    local template = "I have the following code from {{filename}}:\n\n"
                        .. "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Please analyze for code smells and suggest improvements."
                    local agent = gp.get_chat_agent()
                    gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
                end,

                -- example of adding command which opens new chat dedicated for translation
                Translator = function(gp, params)
                    local chat_system_prompt = "You are a Translator, please translate between English and Dutch."
                    local agent = gp.get_chat_agent("gemma3")
                    gp.cmd.ChatNew(params, chat_system_prompt, agent)
                end,
            },
        }
        require("gp").setup(conf)

        require("which-key").add({
            -- VISUAL mode mappings
            -- s, x, v modes are handled the same way by which_key
            {
                mode = { "v" },
                nowait = true,
                remap = false,
                { "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = "ChatNew tabnew" },
                { "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "ChatNew vsplit" },
                { "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>",  desc = "ChatNew split" },
                { "<C-g>a",     ":<C-u>'<,'>GpAppend<cr>",         desc = "Visual Append (after)" },
                { "<C-g>b",     ":<C-u>'<,'>GpPrepend<cr>",        desc = "Visual Prepend (before)" },
                { "<C-g>c",     ":<C-u>'<,'>GpChatNew<cr>",        desc = "Visual Chat New" },
                { "<C-g>g",     group = "generate into new .." },
                { "<C-g>ge",    ":<C-u>'<,'>GpEnew<cr>",           desc = "Visual GpEnew" },
                { "<C-g>gn",    ":<C-u>'<,'>GpNew<cr>",            desc = "Visual GpNew" },
                { "<C-g>gp",    ":<C-u>'<,'>GpPopup<cr>",          desc = "Visual Popup" },
                { "<C-g>gt",    ":<C-u>'<,'>GpTabnew<cr>",         desc = "Visual GpTabnew" },
                { "<C-g>gv",    ":<C-u>'<,'>GpVnew<cr>",           desc = "Visual GpVnew" },
                { "<C-g>i",     ":<C-u>'<,'>GpImplement<cr>",      desc = "Implement selection" },
                { "<C-g>n",     "<cmd>GpNextAgent<cr>",            desc = "Next Agent" },
                { "<C-g>l",     "<cmd>GpSelectAgent<cr>",          desc = "Select Agent" },
                { "<C-g>p",     ":<C-u>'<,'>GpChatPaste<cr>",      desc = "Visual Chat Paste" },
                { "<C-g>r",     ":<C-u>'<,'>GpRewrite<cr>",        desc = "Visual Rewrite" },
                { "<C-g>s",     "<cmd>GpStop<cr>",                 desc = "GpStop" },
                { "<C-g>t",     ":<C-u>'<,'>GpChatToggle<cr>",     desc = "Visual Toggle Chat" },
            },

            -- NORMAL mode mappings
            {
                mode = { "n" },
                nowait = true,
                remap = false,
                { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>",   desc = "New Chat tabnew" },
                { "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>",   desc = "New Chat vsplit" },
                { "<C-g><C-x>", "<cmd>GpChatNew split<cr>",    desc = "New Chat split" },
                { "<C-g>a",     "<cmd>GpAppend<cr>",           desc = "Append (after)" },
                { "<C-g>b",     "<cmd>GpPrepend<cr>",          desc = "Prepend (before)" },
                { "<C-g>c",     "<cmd>GpChatNew<cr>",          desc = "New Chat" },
                { "<C-g>f",     "<cmd>GpChatFinder<cr>",       desc = "Chat Finder" },
                { "<C-g>g",     group = "generate into new .." },
                { "<C-g>ge",    "<cmd>GpEnew<cr>",             desc = "GpEnew" },
                { "<C-g>gn",    "<cmd>GpNew<cr>",              desc = "GpNew" },
                { "<C-g>gp",    "<cmd>GpPopup<cr>",            desc = "Popup" },
                { "<C-g>gt",    "<cmd>GpTabnew<cr>",           desc = "GpTabnew" },
                { "<C-g>gv",    "<cmd>GpVnew<cr>",             desc = "GpVnew" },
                { "<C-g>n",     "<cmd>GpNextAgent<cr>",        desc = "Next Agent" },
                { "<C-g>l",     "<cmd>GpSelectAgent<cr>",      desc = "Select Agent" },
                { "<C-g>r",     "<cmd>GpRewrite<cr>",          desc = "Inline Rewrite" },
                { "<C-g>s",     "<cmd>GpStop<cr>",             desc = "GpStop" },
                { "<C-g>t",     "<cmd>GpChatToggle<cr>",       desc = "Toggle Chat" },
                { "<C-g>x",     "<cmd>GpContext<cr>",          desc = "Toggle GpContext" },
            },

            -- INSERT mode mappings
            {
                mode = { "i" },
                nowait = true,
                remap = false,
                { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>",   desc = "New Chat tabnew" },
                { "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>",   desc = "New Chat vsplit" },
                { "<C-g><C-x>", "<cmd>GpChatNew split<cr>",    desc = "New Chat split" },
                { "<C-g>a",     "<cmd>GpAppend<cr>",           desc = "Append (after)" },
                { "<C-g>b",     "<cmd>GpPrepend<cr>",          desc = "Prepend (before)" },
                { "<C-g>c",     "<cmd>GpChatNew<cr>",          desc = "New Chat" },
                { "<C-g>f",     "<cmd>GpChatFinder<cr>",       desc = "Chat Finder" },
                { "<C-g>g",     group = "generate into new .." },
                { "<C-g>ge",    "<cmd>GpEnew<cr>",             desc = "GpEnew" },
                { "<C-g>gn",    "<cmd>GpNew<cr>",              desc = "GpNew" },
                { "<C-g>gp",    "<cmd>GpPopup<cr>",            desc = "Popup" },
                { "<C-g>gt",    "<cmd>GpTabnew<cr>",           desc = "GpTabnew" },
                { "<C-g>gv",    "<cmd>GpVnew<cr>",             desc = "GpVnew" },
                { "<C-g>n",     "<cmd>GpNextAgent<cr>",        desc = "Next Agent" },
                { "<C-g>l",     "<cmd>GpSelectAgent<cr>",      desc = "Select Agent" },
                { "<C-g>r",     "<cmd>GpRewrite<cr>",          desc = "Inline Rewrite" },
                { "<C-g>s",     "<cmd>GpStop<cr>",             desc = "GpStop" },
                { "<C-g>t",     "<cmd>GpChatToggle<cr>",       desc = "Toggle Chat" },
                { "<C-g>x",     "<cmd>GpContext<cr>",          desc = "Toggle GpContext" },
            },
        })
    end,
}
