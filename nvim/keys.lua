function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- FloaTerm configuration
map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 fish <CR> ")
map('n', "t", ":FloatermToggle myfloat<CR>")
map('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- Split
map('n', "<leader>%", ":vsp <cr>")
map('n', "<leader>\"", ":sp <cr>")
map('n', "<leader>x", ":tabc <cr>")

-- Stop search highlight
map('n', "<leader>-", ":noh <cr>")

-- Save file
map('n', "<leader>w", ":w<cr>")

-- Reload nvim config
map('n', "<leader>sv", ":source $MYVIMRC<cr>")

-- Telescope
map("n", "<leader>fp", "<cmd>lua require('telescope.builtin').git_files()<cr>")
map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>")
map('n', '<leader>fg', "<cmd>lua require'telescope.builtin'.git_status()<cr>")
map('n', '<leader>fr', "<cmd>lua require'telescope.builtin'.buffers({ show_all_buffers = true })<cr>")
map("n", "<Leader>_", "<cmd>lua require('telescope.builtin').live_grep()<cr>")

-- NvimTree
map("n", "<Leader>n", "<cmd>NvimTreeFocus<cr>", {noremap = true, silent = true})
map("n", "<Leader>\\", "<cmd>NvimTreeToggle<cr>", {noremap = true, silent = true})

