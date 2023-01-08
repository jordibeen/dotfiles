function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Split
map('n', "<leader>%", ":vsp <cr>")
map('n', "<leader>\"", ":sp <cr>")
map('n', "<leader>x", ":tabc <cr>")

-- Copy to clipboard
map('v', "<C-c>", ":w !pbcopy<cr>")
map('n', "<C-v>", ":r !pbpaste<cr>")

-- Stop search highlight
map('n', "<leader>-", ":noh <cr>")

-- Reload nvim config
map('n', "<leader>sv", ":source $MYVIMRC<cr>")

-- Telescope
map('n', "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map('n', "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map('n', "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map('n', "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- NvimTree
map('n', "<Leader>n", "<cmd>NvimTreeFocus<cr>")
map('n', "<Leader>\\", "<cmd>NvimTreeToggle<cr>")

-- Git Blame
map('n', "<Leader>bt", ":GitBlameToggle <cr>")
map('n', "<Leader>bo", ":GitBlameOpenCommitURL <cr>")

-- Trouble
map('n', "<Leader>xx", "<cmd>TroubleToggle<cr>")

-- LSP: Go to defintion
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

