return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local treesitter = require('nvim-treesitter')

        local parsers = {
            "bash",
            "comment",
            "css",
            "diff",
            "dockerfile",
            "git_config",
            "gitcommit",
            "gitignore",
            "hcl",
            "helm",
            "html",
            "http",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "rust",
            "ssh_config",
            "sql",
            "terraform",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        }

        for _, parser in ipairs(parsers) do
            treesitter.install(parser)
        end

        local patterns = {}
        for _, parser in ipairs(parsers) do
            local parser_patterns = vim.treesitter.language.get_filetypes(parser)
            for _, pp in pairs(parser_patterns) do
                table.insert(patterns, pp)
            end
        end

        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'

        vim.api.nvim_create_autocmd('FileType', {
            pattern = patterns,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
