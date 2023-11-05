-- Catppuccin theme
require("catppuccin").setup({
    flavour = "frappe",
    transparent_background = true,
    term_colors = false,
    integrations = {
        barbar = true,
        cmp = true,
        neotree = true,
        neogit = true,
        telescope = true,
        mason = true,
        lsp_trouble = true,
        beacon = true,
    },
})

vim.cmd.colorscheme "catppuccin"

-- Colorful window separation
require('colorful-winsep').setup()

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
