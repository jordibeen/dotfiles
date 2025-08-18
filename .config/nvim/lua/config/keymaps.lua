local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Split
map("n", "<leader>%", ":vsp <cr>")
map("n", "<leader>\"", ":sp <cr>")

-- Copy from clipboard
map("n", "<C-v>", ":r !pbpaste<cr>")
map("i", "<C-v>", "<cmd>r !pbpaste<cr>")

-- Copy file path to clipboard
map("n", "<leader>cfp", '<Cmd>let @+ = expand("%:p")<CR>', { desc = "[c]opy [f]ile [p]ath" })
map("n", "<leader>ofp", '<Cmd>!open -R %<CR>', { desc = "[o]pen [f]ile [p]ath in Finder" })
map("n", "<leader>ofd", '<Cmd>!open %:h<CR>', { desc = "[o]pen [f]ile's [d]irectory in Finder" })

-- Telescope
map("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>')
map("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>')
map("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
map("n", "<leader>fs", '<cmd>lua require("telescope.builtin").git_status()<cr>')

-- Trouble
map("n", "<Leader>xx", "<cmd>Trouble diagnostics toggle<cr>")

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
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            bufmap('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
        end
    end
})

-- Undotree Toggle
map("n", "<leader>u", ":UndotreeToggle<cr>")

-- Improved J (cursor stays in place instead of end of line)
map("n", "J", "mzJ`z")

-- Improved Up and Down (cursor stays in the middle)
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Improved search (cursor stays in the middle
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Preserve yank after paste
map("x", "<leader>p", '"_dP')

-- Yank to clip
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- Awesome prime keymap to replace current selected word
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- NeoTree
map("n", "<Leader>n", "<cmd>Neotree reveal focus<cr>")
map("n", "\\", "<cmd>Neotree reveal toggle<cr>")

-- Git
map("n", "<Leader>gos", "<cmd>Git<cr>")
map("n", "<Leader>gov", "<cmd>Gvdiffsplit<cr>")

-- Disable q recording
map("n", "q", "<Nop>")

-- Resize panels
map("n", "<F9>", "<Cmd>resize -5<CR>")           -- decrease height
map("n", "<F10>", "<Cmd>resize +5<CR>")          -- increase width
map("n", "<F11>", "<Cmd>vertical resize -5<CR>") -- decrease width
map("n", "<F12>", "<Cmd>vertical resize +5<CR>") -- increase width

-- Duck
map("n", "<leader>dd", '<Cmd>lua require("duck").hatch()<CR>')
map("n", "<leader>dk", '<Cmd>lua require("duck").cook()<CR>')

-- Markdown Preview
map("n", "<leader>mdp", '<Cmd>MarkdownPreview<CR>')
map("n", "<leader>mds", '<Cmd>MarkdownPreviewStop<CR>')

-- Toggle dark mode
vim.keymap.set('n', '<leader>tdm', function()
    if vim.opt.background:get() == 'dark' then
        vim.cmd(':set background=light')
    else
        vim.cmd(':set background=dark')
    end
end, { desc = '[T]oggle [D]ark [M]ode' })
