vim.lsp.enable({
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
    "yamlls"
})

vim.diagnostic.config({
    virtual_lines = true,
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true
    }
})
