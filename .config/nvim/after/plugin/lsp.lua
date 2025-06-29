-- LSP installer
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "biome",
        "helm_ls",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "ruff",
        "rust_analyzer",
        "sqlls",
        "tailwindcss",
        "terraformls",
        "ts_ls",
        "vimls",
        "yamlls",
    },
})

-- Treesitter (syntax highlighting)
require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "dockerfile",
        "javascript",
        "lua",
        "python",
        "rust",
        "sql",
        "terraform",
        "toml",
        "typescript",
        "yaml",
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Autocompletion
require("blink.cmp").setup({
    keymap = {
        preset = 'default',
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.accept()
                else
                    return cmp.select_and_accept()
                end
            end,
            'snippet_forward',
            'fallback'
        },
        ['<C-b>'] = { 'scroll_documentation_up' },
        ['<C-f>'] = { 'scroll_documentation_down' },
    },
    appearance = { nerd_font_variant = 'mono' },
    completion = { documentation = { auto_show = true } },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    cmdline = {
        completion = { menu = { auto_show = true } },
        keymap = { preset = 'inherit' }
    },
    signature = {
        enabled = true,
        trigger = { enabled = true },
        window = { border = 'single' },
    },

})

-- Formatter
require("conform").setup({
    notify_on_error = true,
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters_by_ft = {
        sql = { "sqlfluff" },
        python = { "isort" },
        -- javascript = { "biome", "biome-organize-imports" },
        -- javascriptreact = { "biome", "biome-organize-imports" },
        -- typescript = { "biome", "biome-organize-imports" },
        -- typescriptreact = { "biome", "biome-organize-imports" },
    },
    formatters = {
        sqlfluff = {
            command = "sqlfluff",
            args = { "format", "--dialect", "postgres", "-" },
            stdin = true,
        }
    }
})
