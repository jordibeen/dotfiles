return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "requirements.txt", "pyproject.toml" },
    settings = {
        args = {
            "--extend-select", "e",
            "--extend-select", "f",
            "--extend-select", "w",
            "--extend-select", "i",
            "--extend-select", "f401" -- unused imports
        }
    }
}
