return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "cargo.toml" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                buildScripts = {
                    enable = true
                }
            },
            imports = {
                granularity = {
                    group = "module"
                },
                prefix = "self"
            },
            procMacro = {
                enable = true
            }
        }

    }
}
