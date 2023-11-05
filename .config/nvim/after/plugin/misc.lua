-- Which Key
require('which-key').setup()

-- Tabs
require("barbar").setup({
    insert_at_end = true,
})

-- Lualine
require("lualine").setup({
    sections = {
        -- lualine_c = {
        --     { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
        -- },
        lualine_x = {},
        lualine_y = { { "filename", path = 1 }, "filetype" },
    },
    options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
    },
})

-- Diagnostics
require("trouble").setup({})
