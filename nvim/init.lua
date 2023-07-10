require('plugins')
require('theme')
require('opts')
require('keys')
require('lsp')
require('tabs')

-- Treesitter (syntax highlighting)
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "lua",
        "rust",
        "toml",
        "yaml",
        "python",
        "typescript",
        "javascript",
        "terraform",
        "dockerfile",
        "sql",
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

 -- Tree
require("nvim-tree").setup({
    git = {
        ignore = false
    },
    filters = {
        dotfiles = false
    }
})

-- Diagnostics
require("trouble").setup({})

-- Telescope
require("telescope").setup {
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}
require("telescope").load_extension('fzf')

-- Tabs
require("barbar").setup({
      exclude_ft = { 'NvimTree' },
})

-- Colorful window separation
require('colorful-winsep').setup()

-- Lualine
require('lualine').setup()

