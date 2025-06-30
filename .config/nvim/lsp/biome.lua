return {
    cmd = { "biome", "lsp-proxy" },
    filetypes = {
        "astro",
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "svelte",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "vue"
    },
    root_markers = { "package.json", "node_modules", "biome.json" },
    workspace_required = true,
    settings = {
        formatter = {
            enabled = true,
        }
    }


}
