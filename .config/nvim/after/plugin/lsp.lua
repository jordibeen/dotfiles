-- Setup LSPs
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "terraformls",
        "ruff",
        "marksman",
        "bashls",
        "yamlls",
        "vimls",
        "ts_ls",
        "tailwindcss",
        "sqlls",
        "helm_ls",
        "jsonls",
        "pyright",
        "biome",
    },
})



-- LSP: OnAttach autoformat
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP auto formatting on save",

    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
})

-- Treesitter (syntax highlighting)
require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "lua",
        "rust",
        "toml",
        "yaml",
        "python",
        "typescript",
        "javascript",
        "terraform",
        "dockerfile",
        "sql",
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Formatter
require("conform").setup({
    formatters_by_ft = {
        sql = { "sqlfluff" },
        python = { "isort" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    },
    formatters = {
        sqlfluff = {
            command = "sqlfluff",
            args = { "format", "--dialect", "postgres", "-" },
            stdin = true,
        }
    }
})
