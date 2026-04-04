vim.lsp.enable({
    "bash-language-server",
    "biome",
    "helm-ls",
    "json-lsp",
    -- "kube-linter",
    "lua-language-server",
    "marksman",
    -- "pyright",
    "ruff",
    "rust-analyzer",
    "tailwindcss-language-server",
    "terraform-ls",
    "ty",
    "typescript-language-server",
    "vim-language-server",
    "yaml-language-server"
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
