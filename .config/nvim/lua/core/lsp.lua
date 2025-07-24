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
    "tailwindcss",
    "terraformls",
    "ts_ls",
    "vimls",
    "yamlls"
})

vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true
    }
})
