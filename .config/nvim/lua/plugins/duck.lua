return {
    "tamton-aquib/duck.nvim",
    opts = {},
    keys = {
        { "<leader>dd", '<Cmd>lua require("duck").hatch()<CR>', desc = "Duck Hatch" },
        { "<leader>dk", '<Cmd>lua require("duck").cook()<CR>',  desc = "Duck Cook" },
    }
}
