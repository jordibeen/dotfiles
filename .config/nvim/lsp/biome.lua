return {
    cmd = { "biome", "lsp-proxy" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.jsx"
    },
    root_markers = { "package.json", "node_modules", "biome.json" },
    workspace_required = true,
    settings = {
        formatter = {
            enabled = true,
        }
    }
}
