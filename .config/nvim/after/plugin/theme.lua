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
require("colorful-winsep").setup()

-- Lualine
require("lualine").setup({
    sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" }
    },
    options = {
        icons_enabled = false,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
    },
    extensions = { "neo-tree" }

})
