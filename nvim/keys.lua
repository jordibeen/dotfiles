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

