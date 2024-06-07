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

return M
