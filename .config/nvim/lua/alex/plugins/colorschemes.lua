return {
    -- Add github addresses here as the others are
    -- I.e. if the theme comes from "https://github.com/projectr0n/github-nvim-theme
    --     then you include "projectr0n/github-nvim-theme"
    {
        "folke/tokyonight.nvim",
        "catppuccin/nvim",
        "scottmckendry/cyberdream.nvim",
        "sainnhe/gruvbox-material",
        "sainnhe/everforest",
        "sainnhe/edge",
        "projekt0n/github-nvim-theme",
    },
    -- The one you want to default to goes here instead. 
    -- If you change, put kanagawa above with the others to leave it as an option.
    {
        "rebelot/kanagawa.nvim",
        config = function()
        vim.cmd.colorscheme('kanagawa')
        end,

    },
}
