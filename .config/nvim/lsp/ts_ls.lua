return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.jsx"
    },
    root_markers = { "package.json", "node_modules", "biome.json" },
    settings = {
        server_capabilities = {
            documentFormattingProvider = false, -- disable ts_ls formatter (using biome instead)
        },
    }
}
