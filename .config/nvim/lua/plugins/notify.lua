return {
    "rcarriga/nvim-notify",
    opts = {
        background_colour = "#000000",
        fps = 30,
        icons = {
            DEBUG = "",
            ERROR = "",
            INFO = "",
            TRACE = "✎",
            WARN = ""
        },
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "fade",
        time_formats = {
            notification = "%T",
            notification_history = "%FT%T"
        },
        timeout = 1000,
        top_down = true
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)
        vim.notify = notify
    end
}
