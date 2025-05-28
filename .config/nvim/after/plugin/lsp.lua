-- LSP installer
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "biome",
        "helm_ls",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "ruff",
        "rust_analyzer",
        "sqlls",
        "tailwindcss",
        "terraformls",
        "ts_ls",
        "vimls",
        "yamlls",
    },
})

-- Lua
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
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

-- Python
vim.lsp.enable("ruff")
vim.lsp.config("ruff", {
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
vim.lsp.enable("pyright")
vim.lsp.config("pyright", { -- Go To Definition capabilities
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                ignore = { '*' }
            },
        },
    },
})


-- Rust
vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {
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

-- TypeScript
vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", {
    server_capabilities = {
        documentFormattingProvider = false, -- disable ts_ls formatter (using biome instead)
    },
})
vim.lsp.enable("biome")
vim.lsp.config("biome", {
    cmd = { "biome", "lsp-proxy" },
    root_markers = { "package.json", "node_modules", "biome.json" }
})

-- Yaml
vim.lsp.enable("yamlls")
vim.lsp.config("yamlls", {
    settings = {
        yaml = {
            format = {
                enable = true
            }
        }
    },
    on_attach = function(_, bufnr)
        local workspace_path = vim.api.nvim_buf_get_name(bufnr)
        if workspace_path then
            local file_path = vim.fn.expand('%:' .. workspace_path .. ':.')
            if string.match(file_path, "helm") then
                vim.diagnostic.enable(false, { bufnr = bufnr })
            end
        end
    end,
})

-- Terraform
vim.lsp.enable("terraformls")
vim.lsp.config("terraformls", {})

-- Markdown
vim.lsp.enable("marksman")
vim.lsp.config("marksman", {})

-- Bash
vim.lsp.enable("bashls")
vim.lsp.config("bashls", {})

-- Vim
vim.lsp.enable("vimls")
vim.lsp.config("vimls", {})

-- Tailwind CSS
vim.lsp.enable("tailwindcss")
vim.lsp.config("tailwindcss", {})

-- SQL
vim.lsp.enable("sqlls")
vim.lsp.config("sqlls", {})

-- JSON
vim.lsp.enable("jsonls")
vim.lsp.config("jsonls", {})

-- Helm
vim.lsp.enable("helm_ls")
vim.lsp.config("helm_ls", {
    settings = {
        ['helm-ls'] = {
            yamlls = {
                path = "yaml-language-server",
            }
        }
    }
})

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

-- LSP: Diagnostics
vim.diagnostic.config({
    virtual_lines = true
})


-- Treesitter (syntax highlighting)
require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "dockerfile",
        "javascript",
        "lua",
        "python",
        "rust",
        "sql",
        "terraform",
        "toml",
        "typescript",
        "yaml",
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Autocompletion
require("blink.cmp").setup({
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

})

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
