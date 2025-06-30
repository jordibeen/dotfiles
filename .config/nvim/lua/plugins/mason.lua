return {
    {
        "mason-org/mason.nvim",
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
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
                "tailwindcss",
                "terraformls",
                "ts_ls",
                "vimls",
                "yamlls",
            }
        }
    }
}
