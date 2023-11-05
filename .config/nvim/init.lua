require('plugins')
require('opts')
require('keys')


-- Tabs
require("barbar").setup({
    insert_at_end = true,
})

-- NeoGit
require('neogit').setup({
    use_telescope = true,
})

-- Which Key
require('which-key').setup()
