return {
    {
        -- LSP/smart-language related package manager
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        -- Allows mason to talk to lsp-config
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" }, -- makes sure that mason runs/installs before this
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { 'pyright', 'lua_ls', 'bashls', 'texlab', 'powershell_es' },
            })
        end,
    },
    {
        -- Allows lsp-config to talk to mason
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true }, -- Extra functionality for actions between files
            { "folke/neodev.nvim", opts = {}} -- Extra functionality for lua specifically
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.pyright.setup({
                capabilities = capabilities,
                -- params['settings'] = {
                --     python = {
                --         pythonPath = require('modules.globals').python_path
                --     }
                -- }
            })
            lspconfig.bashls.setup({
                capabilities = capabilities
            })
            lspconfig.texlab.setup({
                capabilities = capabilities
            })
            lspconfig.powershell_es.setup({
                capabilities = capabilities,
                filetypes = { 'ps1', 'psm1', 'psd1', 'bat' },
                -- bundle_path = "~/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices"
                bundle_path = "~/github/PowerShellEditorServices"
            })
        end,
    },
    {
        -- Non lsp stuff like formatters and linters
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            ensure_installed = { "debugpy" }
        end,
    },
}
