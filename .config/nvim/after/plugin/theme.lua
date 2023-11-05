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
