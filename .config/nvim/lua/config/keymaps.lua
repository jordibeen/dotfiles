local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Split
map("n", "<leader>%", ":vsp <cr>")
map("n", "<leader>\"", ":sp <cr>")

-- Copy file path to clipboard
map("n", "<leader>cfp", '<Cmd>let @+ = expand("%:p")<CR>', { desc = "[c]opy [f]ile [p]ath" })
map("n", "<leader>ofp", '<Cmd>!open -R %<CR>', { desc = "[o]pen [f]ile [p]ath in Finder" })
map("n", "<leader>ofd", '<Cmd>!open %:h<CR>', { desc = "[o]pen [f]ile's [d]irectory in Finder" })

-- LSP buffer
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local bufmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- defaults:
        -- https://neovim.io/doc/user/news-0.11.html#_defaults

        bufmap("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
        bufmap("K", vim.lsp.buf.hover, "Hover Documentation")
        bufmap("gs", vim.lsp.buf.signature_help, "Signature Documentation")
        bufmap("gd", vim.lsp.buf.definition, "Goto definition")
        bufmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
        bufmap("<leader>la", vim.lsp.buf.code_action, "Code Action")
        bufmap("<leader>lr", vim.lsp.buf.rename, "Rename all references")
        bufmap("<leader>lf", vim.lsp.buf.format, "Format")
        bufmap("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            bufmap('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
        end
    end
})

-- Improved J (cursor stays in place instead of end of line)
map("n", "J", "mzJ`z")

-- Improved Up and Down (cursor stays in the middle)
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Improved search (cursor stays in the middle
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Awesome prime keymap to replace current selected word
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Disable q recording
map("n", "q", "<Nop>")

-- Resize panels
map("n", "<F9>", "<Cmd>resize -5<CR>")           -- decrease height
map("n", "<F10>", "<Cmd>resize +5<CR>")          -- increase height
map("n", "<F11>", "<Cmd>vertical resize -5<CR>") -- decrease width
map("n", "<F12>", "<Cmd>vertical resize +5<CR>") -- increase width

-- Toggle dark mode
map("n", "<leader>tdm", function()
    if vim.opt.background:get() == "dark" then
        vim.cmd(":set background=light")
    else
        vim.cmd(":set background=dark")
    end
end, { desc = "[T]oggle [D]ark [M]ode" })

-- Toggle virtual lines
map('n', '<leader>tvl', function()
    local config = vim.diagnostic.config()
    vim.diagnostic.config({
        virtual_lines = not config.virtual_lines,
        virtual_text = not config.virtual_text,
    })
end, { desc = '[T]oggle [V]irtual [L]ines' })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprev<cr>")
map("n", "<S-l>", "<cmd>bnext<cr>")
