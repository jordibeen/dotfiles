-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
})


-- go to last cursor location when opening buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- LSP extras
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = event.buf,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                end,
            })
        end
    end,

})

-- Fix Terraform commenting (https://github.com/LazyVim/LazyVim/discussions/654#discussioncomment-10978917)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "terraform",
    callback = function()
        vim.bo.commentstring = "# %s"
    end
})

function Light()
    vim.cmd("set background=light")
end

function Dark()
    vim.cmd("set background=dark")
end

vim.cmd("command Light silent lua Light()")
vim.cmd("command Dark silent lua Dark()")
