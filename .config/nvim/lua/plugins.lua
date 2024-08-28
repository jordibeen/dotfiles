local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
    -- catppuccin theme--
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
    },

    -- LSP
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
    },

    -- Autocompletion framework
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        }
    },

    -- Syntax Highlighting
    "nvim-treesitter/nvim-treesitter",

    -- Debug Adapter
    "puremourning/vimspector",

    -- Finding files
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "junegunn/fzf",
            "nvim-telescope/telescope-ui-select.nvim",
        }
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },

    -- Diagnostics
    {
        "folke/trouble.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
    },

    -- Seamless navigation between vim and tmux
    "christoomey/vim-tmux-navigator",

    -- Helm files
    "towolf/vim-helm",

    -- Git Blame
    "f-person/git-blame.nvim",

    -- Undotree
    "mbbill/undotree",

    -- Colorful window separation
    "nvim-zh/colorful-winsep.nvim",

    -- lualine
    "nvim-lualine/lualine.nvim",

    -- File Tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        }
    },

    -- NeoGit
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
        }
    },

    -- Which Key
    "folke/which-key.nvim",

    -- Beacon
    "danilamihailov/beacon.nvim",

    -- Duck
    "tamton-aquib/duck.nvim",

    -- Formatting
    "stevearc/conform.nvim",

    -- LLM
    "David-Kunz/gen.nvim",

    -- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- Arrow
    "otavioschwanck/arrow.nvim",
}

require("lazy").setup(plugins, {})
