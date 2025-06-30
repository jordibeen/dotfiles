return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    settings = {
        yaml = {
            format = {
                enable = true
            }
        }
    },
    on_attach = function(_, bufnr)
        local workspace_path = vim.api.nvim_buf_get_name(bufnr)
        if workspace_path then
            local file_path = vim.fn.expand('%:' .. workspace_path .. ':.')
            if string.match(file_path, "helm") then
                vim.diagnostic.enable(false, { bufnr = bufnr })
            end
        end
    end,
}
