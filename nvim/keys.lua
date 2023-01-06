function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
map('n', "Dw", ":call vimspector#AddWatch()<cr>")
map('n', "De", ":call vimspector#Evaluate()<cr>")

-- FloaTerm configuration
map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 fish <CR> ")
map('n', "t", ":FloatermToggle myfloat<CR>")
map('t', "<Esc>", "<C-\\><C-n>:q<CR>")


-- Telescope key mappings
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>pf", "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>ps", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>n", "<cmd>NvimTreeFocus<cr>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Leader>\\", "<cmd>NvimTreeToggle<cr>", {noremap = true, silent = true})
