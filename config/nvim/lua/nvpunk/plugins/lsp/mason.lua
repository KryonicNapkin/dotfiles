-- plugin installer and manager for LSP, DAP, formatters and more
return {
    'williamboman/mason.nvim',
    dependencies = {
        -- bridge mason and lspconfig
        { 'williamboman/mason-lspconfig.nvim' },
        -- bridge mason and null-ls
        { 'jay-babu/mason-null-ls.nvim' },
    },
    config = function()
        require('mason').setup {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '…',
                    package_uninstalled = '✗',
                },
                keymaps = {
                    -- expand a package
                    toggle_package_expand = '<CR>',
                    -- install the package under the current cursor position
                    install_package = 'i',
                    -- reinstall/update the package under the current cursor position
                    update_package = 'u',
                    -- check for new version for the package under the current cursor position
                    check_package_version = 'c',
                    -- update all installed packages
                    update_all_packages = 'U',
                    -- check which installed packages are outdated
                    check_outdated_packages = 'C',
                    -- uninstall a package
                    uninstall_package = 'X',
                    -- cancel a package installation
                    cancel_installation = '<C-c>',
                    -- apply language filter
                    apply_language_filter = '<C-f>',
                },
                border = require('nvpunk.preferences').get_window_border(),
            },
            max_concurrent_installers = 4,
        }
    end,
}
