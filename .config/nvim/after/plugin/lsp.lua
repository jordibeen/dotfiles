-- Setup LSPs
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "terraformls",
        "ruff_lsp",
        "marksman",
        "bashls",
        "yamlls",
        "vimls",
        "tsserver",
        "tailwindcss",
        "sqlls",
        "helm_ls",
        "pylsp",
        "jsonls",
    },
})


local cmp = require("cmp")
local lspconfig = require("lspconfig")

-- LSP: OnAttach autoformat
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP auto formatting on save",

    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
})

-- Lua
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim",
                },
            },
        },
    },
})

-- Rust
lspconfig.rust_analyzer.setup({
    on_attach = function(client)
        require("completion").on_attach(client)
    end,
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
            },
        }
    }
})

-- Terraform
lspconfig.terraformls.setup({})

-- Python
lspconfig.ruff_lsp.setup({
    init_options = {
        settings = {
            args = {
                "--extend-select", "E",
                "--extend-select", "F",
                "--extend-select", "W",
                "--extend-select", "I",
            }
        }
    }
})
lspconfig.pylsp.setup({ -- used only for Go To Definition capabilities and black formatting
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false
                },
                flake8 = {
                    enabled = false
                },
                pyflakes = {
                    enabled = false
                },
                mccabe = {
                    enabled = false
                },
                ruff = {
                    enabled = false -- enabled with Mason's ruff_lsp instead
                },
                black = {
                    enabled = false
                },
            }
        }
    }
})

-- Markdown
lspconfig.marksman.setup({})

-- Bash
lspconfig.bashls.setup({})

-- Yaml
lspconfig.yamlls.setup({})

-- Vim
lspconfig.vimls.setup({})

-- TypeScript
lspconfig.tsserver.setup({})

-- Tailwind CSS
lspconfig.tailwindcss.setup({})

-- SQL
lspconfig.sqlls.setup({})

-- JSON
lspconfig.jsonls.setup({})

-- Helm
lspconfig.helm_ls.setup({})

-- Autocompletion
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer" },
        { name = "path" },
        { name = "vsnip" },
        { name = "calc" },
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }
})

-- Autocompletion: Commandline
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Autocompletion: Search
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "path" },
        { name = "cmdline" }
    }
})

-- Treesitter (syntax highlighting)
require("nvim-treesitter.configs").setup {
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

-- Formatter
require("conform").setup({
    formatters_by_ft = {
        javascript = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        sql = { "sqlfluff" },
        python = { "black" },
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    },
    formatters = {
        sqlfluff = {
            command = "sqlfluff",
            args = { "format", "--dialect", "postgres", "-" },
            stdin = true,
        }
    }
})
