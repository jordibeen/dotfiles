return {
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "dockerfile",
                "javascript",
                "lua",
                "python",
                "rust",
                "sql",
                "terraform",
                "toml",
                "typescript",
                "yaml",
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            fold = {
                enable = true
            },
        })
    end
}
