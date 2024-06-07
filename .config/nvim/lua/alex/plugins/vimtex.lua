return {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    init = function()
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_mode = 1
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_quickfix_mode = 1 -- suppress error reporting on save and build
        vim.g.tex_flavor = 'latex'
    end
}
