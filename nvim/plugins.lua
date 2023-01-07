return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    -- Mason manages LSP servers, debuggers and linters
    use 'williamboman/mason.nvim'    
    use 'williamboman/mason-lspconfig.nvim'

    -- Install collection of LSP configs
    use 'neovim/nvim-lspconfig' 

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

    -- Python format/lint
    use 'psf/black'
    use 'fisadev/vim-isort'

    -- Git Blame
    use 'f-person/git-blame.nvim'

    -- Gruvbox theme
    use "ellisonleao/gruvbox.nvim"

end)


