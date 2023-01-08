----Set completeopt to have a better completion experience
---- :help completeopt
---- menuone: popup even when there's only one match
---- noinsert: Do not insert text until a selection is made
---- noselect: Do not select, force to select one from the menu
---- shortness: avoid showing extra messages when using completion
---- updatetime: set updatetime for CursorHold
--vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}

local set = vim.opt

set.number = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 0
set.expandtab = true
set.swapfile = false
set.scrolloff = 10
set.list = true
set.lcs = "space:·"

-- Leader key
vim.g.mapleader = " "

-- GitBlame
vim.g.gitblame_date_format = '%r'


