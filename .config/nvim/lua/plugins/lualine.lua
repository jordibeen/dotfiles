return {
    "nvim-lualine/lualine.nvim",
    opts = {
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

    }
}
