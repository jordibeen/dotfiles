return {
    "iamcco/markdown-preview.nvim",
    cmd = {
        "MarkdownPreviewToggle",
        "MarkdownPreview",
        "MarkdownPreviewStop"
    },
    ft = { "markdown" },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    keys = {
        { "<leader>mdp", '<Cmd>MarkdownPreview<CR>',     desc = "Markdown Preview Start" },
        { "<leader>mds", '<Cmd>MarkdownPreviewStop<CR>', desc = "Markdown Preview Stop" },
    }
}
