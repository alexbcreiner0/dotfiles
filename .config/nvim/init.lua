-- Attempt to mount laptop server
local status = pcall(function()
    os.execute('mount ~/Laptop-Server > /dev/null 2>&1')
end)
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"
require("alex.core")
require("alex.lazy")

local globals = require("modules.globals")

-- Transparency enabled by default
globals.toggle_transparency()

vim.api.nvim_buf_create_user_command(0, 'ToggleTransparency', function()
    globals.toggle_transparency()
end, {})

-- Set transparent background

-- Adjust other colors as needed
-- vim.api.nvim_set_hl(0, 'LineNr', { fg = '#5eacd3' })
-- vim.api.nvim_set_hl(0, 'Comment', { fg = '#5eacd3' })
