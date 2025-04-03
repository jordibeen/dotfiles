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
    -- catppuccin theme
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
        },
    },

    -- Autocompletion framework
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'default',
                ['<Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    'snippet_forward',
                    'fallback'
                },
                ['<C-b>'] = { 'scroll_documentation_up' },
                ['<C-f>'] = { 'scroll_documentation_down' },
            },
            appearance = { nerd_font_variant = 'mono' },
            completion = { documentation = { auto_show = true } },
            sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            cmdline = {
                completion = { menu = { auto_show = true } },
                keymap = { preset = 'inherit' }
            },
            signature = {
                enabled = true,
                trigger = { enabled = true },
                window = { border = 'single' },
            },
        },
        opts_extend = { "sources.default" }
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },

        opts = {
            servers = {
                -- Lua
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = {
                                    "vim",
                                },
                            },
                        },
                    },
                },

                -- Rust
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "self",
                            },
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            procMacro = {
                                enable = true
                            }
                        }
                    }
                },

                -- Terraform
                terraformls = {},

                -- Python
                ruff = {
                    init_options = {
                        settings = {
                            args = {
                                "--extend-select", "E",
                                "--extend-select", "F",
                                "--extend-select", "W",
                                "--extend-select", "I",
                                "--extend-select", "F401" -- unused imports
                            }
                        }
                    }
                },

                pyright = { -- Go To Definition capabilities
                    settings = {
                        pyright = {
                            disableOrganizeImports = true,
                        },
                        python = {
                            analysis = {
                                ignore = { '*' },
                            },
                        },
                    },
                },

                -- Markdown
                marksman = {},

                -- Bash
                bashls = {},

                -- Yaml
                yamlls = {
                    on_attach = function(client, bufnr)
                        local workspace_path = vim.api.nvim_buf_get_name(bufnr)
                        if workspace_path then
                            local file_path = vim.fn.expand('%:' .. workspace_path .. ':.')
                            if string.match(file_path, "helm") then
                                vim.diagnostic.disable(bufnr)
                            end
                        end
                    end,
                    settings = {
                        yaml = {
                            format = {
                                enable = true
                            }
                        }
                    }
                },

                -- Vim
                vimls = {},

                -- TypeScript
                ts_ls = {
                    server_capabilities = {
                        documentFormattingProvider = false, -- disable ts_ls formatter (using biome instead)
                    },
                },
                biome = {
                    -- cmd = { "biome", "lsp-proxy" },
                },

                -- Tailwind CSS
                tailwindcss = {},

                -- SQL
                sqlls = {},

                -- JSON
                jsonls = {},

                -- Helm
                helm_ls = {},
            },
        },

        config = function(_, opts)
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

                -- TODO: move this to the opts config instead
                if server == "biome" then
                    config.root_dir = lspconfig.util.root_pattern("package.json", "node_modules", "biome.json")
                end

                lspconfig[server].setup(config)
            end
        end
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

    -- Fugitive
    "tpope/vim-fugitive",

    -- Which Key
    "folke/which-key.nvim",

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

    -- Code block commenting
    "tpope/vim-commentary",
}

require("lazy").setup(plugins, {})
