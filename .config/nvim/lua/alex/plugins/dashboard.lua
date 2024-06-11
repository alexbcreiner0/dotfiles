function nav_configs()
    vim.api.nvim_command('cd ~/.config')
    vim.cmd('Telescope find_files')
end

function nav_school()
    local success = pcall(function()
    vim.api.nvim_command('cd ~/Laptop-Server/Current-Semester')
    end)
    if success then
        vim.cmd('Telescope find_files')
    else
        require("notify")('Error opening folder. Has something changed about your server?')
    end
end

function nav_vault()
    vim.api.nvim_command('cd ' .. obsidian_path)
    vim.cmd('Telescope find_files')
end

function disable_indent_guide()
    vim.cmd('IBLDisable')
end

function enable_indent_guide()
    vim.cmd('IBLEnable')
end

function on_buf_leave()
--    local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
   local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

--    print("buftype is " .. buftype .. " and filetype is " .. filetype)
    pcall(function()
        if filetype ~= 'TelescopePrompt' and filetype ~= 'dashboard' and filetype ~= neo-tree then
            enable_indent_guide()
        end
    end)
end

return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                -- 'groups' are literally just colors as far as I can tell
                shortcut = {
                    {
                        icon_hl = '@variable',
                        desc = 'Local Files',
                        group = '@property',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    -- Change this to a relative path that always leads to vault
                    {
                        desc = 'Obsidian Vault',
                        group = 'Label',
                        action = 'ObsidianSearch',
                        key = 'v' },
                    {
                        desc = 'Config Files',
                        group = 'DiagnosticHint',
                        action = nav_configs,
                        key = 'c',
                    },
                    {
                        desc = 'School',
                        group = 'Number',
                        action = nav_school,
                        key = 'd',
                    },
                },
            },
        }
        vim.api.nvim_create_augroup('DashboardIndentGuide', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'dashboard',
            callback = disable_indent_guide,
            group = 'DashboardIndentGuide'
        })
        vim.api.nvim_create_autocmd('BufLeave', {
            pattern = '*',
            callback = on_buf_leave,
            group = 'DashboardIndentGuide'
        })
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'} }
}
