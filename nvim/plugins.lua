return require('packer').startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Gruvbox theme
    use "ellisonleao/gruvbox.nvim"

    -- LSP
    use {
        'williamboman/mason.nvim',
        requires = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'jose-elias-alvarez/null-ls.nvim',
        },
    }

    -- Automatically set up lspconfig for rust-analyzer
    use 'simrat39/rust-tools.nvim'

    -- Autocompletion framework
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        }
    }

    -- Syntax Highlighting
    use 'nvim-treesitter/nvim-treesitter'

    -- Debug Adapter
    use 'puremourning/vimspector'

    -- Finding files
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'junegunn/fzf',
        }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    -- File Tree
    use {
        'nvim-tree/nvim-tree.lua',
         requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }

    -- Diagnostics
    use {
        "folke/trouble.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    }

    -- Seamless navigation between vim and tmux
    use 'christoomey/vim-tmux-navigator'

    -- Helm files
    use 'towolf/vim-helm'

    -- Code block commenting
    use 'tpope/vim-commentary'

    -- Git Blame
    use 'f-person/git-blame.nvim'

    -- Undotree
    use 'mbbill/undotree'

    -- Tabs
    use 'romgrk/barbar.nvim'

    -- Multiline
    use 'mg979/vim-visual-multi'

    -- Git
    use 'tpope/vim-fugitive'
end)


