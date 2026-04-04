return {
    {
        "mason-org/mason.nvim",
        opts = {},
        config = function(_, opts)
            local mason = require("mason")
            mason.setup(opts)

            local registry = require("mason-registry")
            local packages = {
                "bash-language-server",
                "biome",
                "json-lsp",
                "helm-ls",
                "lua-language-server",
                "marksman",
                "ty",
                "ruff",
                "rust-analyzer",
                "tailwindcss-language-server",
                "terraform-ls",
                "typescript-language-server",
                "vim-language-server",
                "yaml-language-server",
            }

            for _, pkg_name in ipairs(packages) do
                local ok, pkg = pcall(registry.get_package, pkg_name)
                if ok and not pkg:is_installed() then
                    pkg:install()
                end
            end
        end
    }
}
