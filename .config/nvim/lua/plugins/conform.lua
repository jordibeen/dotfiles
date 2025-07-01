return {
    "stevearc/conform.nvim",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    opts = {
        notify_on_error = true,
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            python = { "isort" },
            json = { "jq" },
            jsonc = { "jq" },
            javascript = { "biome-organize-imports" },
            javascriptreact = { "biome-organize-imports" },
            typescript = { "biome-organize-imports" },
            typescriptreact = { "biome-organize-imports" },
        }
    }
}
