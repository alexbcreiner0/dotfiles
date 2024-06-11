return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        notify = require("notify")
        vim.notify = notify
        notify.setup({
            fps = 60,
            stages = 'slide',
            timeout = 3000
        })
    end
}
