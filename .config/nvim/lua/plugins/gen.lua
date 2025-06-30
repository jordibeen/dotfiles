local default_model = "gemma3:4b"
local coding_model = "qwen2.5-coder"
local reasoning_model = "qwen3:4b"

return {
    "David-Kunz/gen.nvim",
    opts = {
        model = default_model,
        quit_map = "q",         -- set keymap for close the response window
        retry_map = "<c-r>",    -- set keymap to re-send the current prompt
        accept_map = "<c-cr>",  -- set keymap to replace the previous selection with the last result
        host = "localhost",     -- The host running the Ollama service.
        port = "11434",         -- The port on which the Ollama service is listening.
        display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
        show_prompt = true,     -- Shows the prompt submitted to Ollama.
        show_model = true,      -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = true,   -- Never closes the window automatically.
        hidden = false,         -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
        init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
        -- Function to initialize Ollama
        command = function(options)
            local body = { model = options.model, stream = true }
            return "curl --silent --no-buffer -X POST http://" ..
                options.host .. ":" .. options.port .. "/api/chat -d $body"
        end,
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a command string.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        -- list_models = '<omitted lua function>', -- Retrieves a list of model names
        result_filetype = "markdown", -- Configure filetype of the result buffer
        debug = false                 -- Prints errors and the command which is run.

    },
    config = function(_, opts)
        local gen = require("gen")
        gen.setup(opts)
        gen.prompts['Explain_Code'] = {
            model = coding_model,
            prompt = "Please explain the following code in detail:\n$text",
        }
        gen.prompts['Improve_Code'] = {
            model = coding_model,
            prompt = "Please make a suggestion on how to improve the following code:\n$text",
        }
    end
}
