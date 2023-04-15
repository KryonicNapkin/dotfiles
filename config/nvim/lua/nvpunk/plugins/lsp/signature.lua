-- step by step signature help
return {
    'ray-x/lsp_signature.nvim',
    config = function()
        require('lsp_signature').setup {
            handler_opts = {
                border = require('nvpunk.preferences').get_small_window_border(),
            },
            hint_enable = false,
        }
    end,
}
