return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "requirements.txt", "pyproject.toml" },
    settings = {
        pyright = {
            disableOrganizeImports = true
        },
        python = {
            analysis = {
                ignore = { "*" },
            }
        }
    }
}
