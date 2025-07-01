return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
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
        }
    }
}
