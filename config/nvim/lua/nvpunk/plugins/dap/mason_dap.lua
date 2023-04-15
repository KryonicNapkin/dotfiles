return {
    'jay-babu/mason-nvim-dap.nvim',
    config = function()
        local mason_dap = require 'mason-nvim-dap'
        mason_dap.setup {
            ensure_installed = {
                'python',
            },
            automatic_installation = true,
            automatic_setup = true,
        }
        mason_dap.setup_handlers()
    end,
}
