require('plugins')
-- require('theme')
require('opts')
require('keys')
-- require('lsp')
-- require('tabs')

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
}

-- File Tree
require("neo-tree").setup({
    buffers = {
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
    },

    filesystem = {
        filtered_items = {
            always_show = {
                ".gitignore",
                ".env",
                ".github",
                ".test.yaml",
                ".production.yaml",
                "terraform.tfvars",
            }
        }
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
    insert_at_end = true,
})

-- Colorful window separation
require('colorful-winsep').setup()


-- NeoGit
require('neogit').setup({
    use_telescope = true,
})

-- Which Key
require('which-key').setup()
