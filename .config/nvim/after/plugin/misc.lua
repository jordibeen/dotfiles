-- Which Key
require('which-key').setup()

-- Tabs
require("barbar").setup({
    insert_at_end = true,
})

-- Lualine
require('lualine').setup()

-- Diagnostics
require("trouble").setup({})
