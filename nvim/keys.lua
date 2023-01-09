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
map('v', "<C-c>", ":'<'>w !pbcopy<cr>")
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
map('n', "<Leader>bt", "<cmd>GitBlameToggle<cr>")
map('n', "<Leader>bo", "<cmd>GitBlameOpenCommitURL<cr>")

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


-- QuickFix
map('n', "<leader>qfc", "<cmd>cclose<cr>")
map('n', "<leader>qfo", "<cmd>copen<cr>")
map('n', "<C-k>", "<cmd>cnext<cr>zz")
map('n', "<C-j>", "<cmd>cprev<cr>zz")
map('n', "<leader>k", "<cmd>lnext<cr>zz")
map('n', "<leader>j", "<cmd>lprev<cr>zz")


-- Undotree Toggle
map('n', "<leader>u", ":UndotreeToggle<cr>")

-- Move visual selection up and down
map('v', "J", ":m '>+1<cr>gv=gv")
map('v', "K", ":m '<-2<cr>gv=gv")

-- Improved J (cursor stays in place instead of end of line)
map('n', "J", "mzJ`z")

-- Improved Up and Down (cursor stays in the middle)
map('n', "<C-d>", "<C-d>zz")
map('n', "<C-u>", "<C-u>zz")

-- Improved search (cursor stays in the middle
map('n', "n", "nzzzv")
map('n', "N", "Nzzzv")

-- Preserve yank after paste
map('x', "<leader>p", "\"_dP")

-- Yank to clip
map('n', "<leader>y", "\"+y")
map('v', "<leader>y", "\"+y")
map('n', "<leader>Y", "\"+Y")

-- Awesome prime keymap to replace current selected word
map('n', "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
