-- -- Gruvbox Theme
-- vim.o.background = "dark"
-- require("gruvbox").setup()
-- vim.cmd("colorscheme gruvbox")

-- Catppuccin theme
require("catppuccin").setup({
    flavour = "frappe",
    transparent_background = true,
    term_colors = false,
    integrations = {
        cmp = true,
        nvimtree = true,
        telescope = true,
        barbar = true,
        mason = true,
    },
})

vim.cmd.colorscheme "catppuccin"
