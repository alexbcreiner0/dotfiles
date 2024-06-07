-- Attempt to mount laptop server
local status = pcall(function()
    os.execute('mount ~/Laptop-Server > /dev/null 2>&1')
end)
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"
require("alex.core")
require("alex.lazy")

local globals = require("modules.globals")

_G.test = globals.test

vim.api.nvim_buf_create_user_command(0, 'Test', function()
    globals.test()
end, {})

-- Set transparent background
vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'NONE', bg = 'NONE' })
-- Adjust other colors as needed
-- vim.api.nvim_set_hl(0, 'LineNr', { fg = '#5eacd3' })
-- vim.api.nvim_set_hl(0, 'Comment', { fg = '#5eacd3' })
