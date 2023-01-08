-- Install LSPs
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua",
        "rust_analyzer",
        "terraformls",
        "pylsp",
        "marksman",
        "bashls",
        "yamlls",
        "vimls",
    }
})

local lspconfig = require('lspconfig')
local null_ls = require("null-ls")

-- Lua
lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    'vim'
                }
            }
        }
    }
}

-- Rust
lspconfig.rust_analyzer.setup {}

-- Terraform
lspconfig.terraformls.setup {}

-- Python
lspconfig.pylsp.setup {}

-- Markdown
lspconfig.marksman.setup {}

-- Bash
lspconfig.bashls.setup {}

-- Yaml
lspconfig.yamlls.setup {}

-- Vim
lspconfig.vimls.setup {}

-- Auto formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.stylua,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
