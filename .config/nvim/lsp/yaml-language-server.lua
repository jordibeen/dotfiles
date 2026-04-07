return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    settings = {
        yaml = {
            format = {
                enable = true
            },
            validate = true,
            hover = true,
            completion = true,
            schemas = vim.tbl_extend("force", {
                kubernetes = "{k8s/**/*.yaml,kubectl-edit-*.yaml}",
                ["https://json.schemastore.org/chart.json"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/helmfile.json"] = "helmfile.{yml,yaml}",
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
                ["https://json.schemastore.org/github-action.json"] = ".github/actions/*/action.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json"] =
                "{docker-compose,compose}*.{yml,yaml}",
            }, {}),
        }
    }
}
