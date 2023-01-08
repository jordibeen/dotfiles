require('plugins')
require('theme')
require('opts')
require('keys')
require('lsp')

-- Rust Tools setup
require("rust-tools").setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end
    },
})

-- Treesitter (syntax highlighting)
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "lua",
        "rust",
        "toml",
        "python",
        "typescript",
        "javascript",
        "terraform",
        "dockerfile",
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


require("nvim-tree").setup()
require("trouble").setup()

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

