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

-- Setup LSPs
local lspconfig = require('lspconfig')

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
lspconfig.pyright.setup({ -- Go To Definition capabilities
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
 
-- TypeScript
lspconfig.ts_ls.setup({
    server_capabilities = {
        documentFormattingProvider = false, -- disable ts_ls formatter (using biome instead)
    },
})
lspconfig.biome.setup({
    cmd = { "biome", "lsp-proxy" },
    root_dir = lspconfig.util.root_pattern("package.json", "node_modules", "biome.json")
})

-- Yaml
lspconfig.yamlls.setup({
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
                vim.diagnostic.disable(bufnr)
            end
        end
    end,
})

-- Terraform
lspconfig.terraformls.setup({})

-- Markdown
lspconfig.marksman.setup({})

-- Bash
lspconfig.bashls.setup({})

-- Vim
lspconfig.vimls.setup({})

-- Tailwind CSS
lspconfig.tailwindcss.setup({})

-- SQL
lspconfig.sqlls.setup({})

-- JSON
lspconfig.jsonls.setup({})

-- Helm
lspconfig.helm_ls.setup({})

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
