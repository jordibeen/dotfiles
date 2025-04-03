-- Setup LSPs
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "terraformls",
        "ruff",
        "marksman",
        "bashls",
        "yamlls",
        "vimls",
        "ts_ls",
        "tailwindcss",
        "sqlls",
        "helm_ls",
        "jsonls",
        "pyright",
        "biome",
    },
})


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
})

-- Terraform
lspconfig.terraformls.setup({})

-- Python
lspconfig.ruff.setup({
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
})
lspconfig.pyright.setup { -- Go To Definition capabilities
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
}

-- Markdown
lspconfig.marksman.setup({})

-- Bash
lspconfig.bashls.setup({})

-- Yaml
lspconfig.yamlls.setup({
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
})

-- Vim
lspconfig.vimls.setup({})

-- TypeScript
lspconfig.ts_ls.setup({
    server_capabilities = {
        documentFormattingProvider = false, -- disable ts_ls formatter (using biome instead)
    },
})
lspconfig.biome.setup({
    cmd = { "biome", "lsp-proxy" },
    root_dir = lspconfig.util.root_pattern("package.json", "node_modules", "biome.json"),
});

-- Tailwind CSS
lspconfig.tailwindcss.setup({})

-- SQL
lspconfig.sqlls.setup({})

-- JSON
lspconfig.jsonls.setup({})

-- Helm
lspconfig.helm_ls.setup({})

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
        sql = { "sqlfluff" },
        python = { "isort" },
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
