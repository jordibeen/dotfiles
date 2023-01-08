return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Gruvbox theme
    use "ellisonleao/gruvbox.nvim"

    -- Mason manages LSP servers, debuggers and linters
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

    -- Completion framework:
    use 'hrsh7th/nvim-cmp'

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'

    -- Parsing library
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
end)


