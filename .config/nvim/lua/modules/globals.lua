local M = {}

function M.test()
    print('Hello world!')
end

M.is_transparent = false
function M.toggle_transparency()
    if not M.is_transparent then
        vim.api.nvim_set_hl(0, 'Normal', { ctermbg = 'NONE', bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'FloatBorder', { ctermbg = 'NONE', bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'TelescopeBorder', {ctermbg = 'NONE', bg = 'NONE'})
        vim.api.nvim_set_hl(0, 'LineNr', { ctermbg = 'NONE', bg = 'NONE' })
        M.is_transparent = true
    elseif M.is_transparent then
        local colorscheme = vim.api.nvim_exec('colorscheme', true)
        vim.cmd.colorscheme(colorscheme)
        M.is_transparent = false
    end

end

function M.source_config()
    local dir = vim.fn.stdpath('config')
    -- Resolve symlink if they are using something like GNU Stow
    local handle = io.popen('readlink -f "' .. dir .. '"')
    if handle then
        dir = handle:read("*a"):gsub("%s+", "")
        handle:close()
    end
    -- At this point, dir should point at the user's config folder
    local sh_cmd = 'find "' .. dir .. '" -type f -name "*.lua"'
    handle = io.popen(sh_cmd)
    local file_list = {}
    if handle then
        local file_string = handle:read("*a")
        file_list = vim.split(file_string, "\n")
        handle:close()
    end
    vim.print(file_list)
    if file_list then
        for _, file in ipairs(file_list) do
            if file ~= "" then
                vim.cmd('source ' .. file)
            end
        end
    end
end

return M
