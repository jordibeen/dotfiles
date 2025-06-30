return {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm", "yaml.helm-values" },
    root_markers = { "Chart.yaml" },
    settings = {
        ['helm-ls'] = {
            yamlls = {
                path = "yaml-language-server",
            }
        }
    },
}
