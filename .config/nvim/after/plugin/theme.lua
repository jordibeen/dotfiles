-- Catppuccin theme
require("catppuccin").setup({
    flavour = "frappe",
    transparent_background = true,
    term_colors = false,
    integrations = {
        barbar = true,
        neotree = true,
        telescope = true,
        mason = true,
        lsp_trouble = true,
        blink_cmp = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
    },
})

vim.cmd("colorscheme catppuccin")

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

function Light()
    vim.cmd("set background=light")
end

function Dark()
    vim.cmd("set background=dark")
end

vim.cmd("command Light silent lua Light()")
vim.cmd("command Dark silent lua Dark()")
