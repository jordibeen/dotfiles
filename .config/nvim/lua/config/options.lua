-- Leader
vim.g.mapleader = " "

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Cursor line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Four space indents
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true

-- Smarter indenting
vim.opt.smartindent = true

-- Enable linewrap
vim.opt.wrap = true

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

-- -- Show spaces
-- vim.opt.list = true
-- vim.opt.lcs = "space:·"

-- Autocompletion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Which Key
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Hide "~" end of buffer indication
vim.opt.fillchars = { eob = " " }

-- Substitution panel
vim.opt.inccommand = "split"

-- Folding using treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Don't fold by default
