return {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm", "helmfile" },
    root_markers = { "Chart.yaml" },
    settings = {
        ['helm-ls'] = {
            yamlls = {
                path = "yaml-language-server",
            }
        }
    },
}
