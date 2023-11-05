-- Leader
vim.g.mapleader = " "

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Four space indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true

-- Smarter indenting
vim.opt.smartindent = true

-- Disable linewrap
vim.opt.wrap = false

-- No vim backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Long running undo's
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Better searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Good colors
vim.opt.termguicolors = true

-- Always show 8 lines before and after scroll
vim.opt.scrolloff = 8

-- Fast update time
vim.opt.updatetime = 50

-- Color column
-- vim.opt.colorcolumn = "80"

-- Show spaces
vim.opt.list = true
vim.opt.lcs = "space:·"

-- Autocompletion
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- GitBlame
vim.g.gitblame_date_format = '%r'

-- Which Key
vim.o.timeout = true
vim.o.timeoutlen = 300
