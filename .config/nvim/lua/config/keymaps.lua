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

-- Copy to clipboard
map("v", "<C-c>", ':" < ">w !pbcopy<cr>')
map("n", "<C-v>", ":r !pbpaste<cr>")

-- Yank file path to clipboard
map("n", "<leader>cfp", '<Cmd>let @+ = expand(" % ")<CR>')

-- Telescope
map("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>')
map("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>')
map("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
map("n", "<leader>fs", '<cmd>lua require("telescope.builtin").git_status()<cr>')

-- Git Blame
map("n", "<Leader>bt", "<cmd>GitBlameToggle<cr>")
map("n", "<Leader>bo", "<cmd>GitBlameOpenCommitURL<cr>")

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

-- Move visual selection up and down
map("v", "J", ':m ">+1<cr>gv=gv')
map("v", "K", ':m "<-2<cr>gv=gv')

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
map("n", "<F9>", "<Cmd>vertical resize -5<CR>")  -- decrease width
map("n", "<F10>", "<Cmd>resize -5<CR>")          -- decrease height
map("n", "<F11>", "<Cmd>resize +5<CR>")          -- increase width
map("n", "<F12>", "<Cmd>vertical resize +5<CR>") -- increase width

-- Duck
map("n", "<leader>dd", '<Cmd>lua require("duck").hatch()<CR>')
map("n", "<leader>dk", '<Cmd>lua require("duck").cook()<CR>')

-- Notes
map("n", "<leader>mdp", '<Cmd>MarkdownPreview<CR>')
map("n", "<leader>mds", '<Cmd>MarkdownPreviewStop<CR>')

-- LLM
map("n", "<leader>ql", '<Cmd>lua require("gen").select_model()<CR>')
map("n", "<leader>qq", ':Gen Chat<CR>')
map("v", "<leader>qe", ':Gen Explain_Code<CR>')
map("v", "<leader>qi", ':Gen Improve_Code<CR>')
