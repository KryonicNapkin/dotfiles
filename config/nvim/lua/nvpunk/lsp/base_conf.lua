local diagnostic_conf = {
    -- inline errors
    virtual_text = true,
    signs = {
        active = require('nvpunk.internals.signs').lsp_signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = require('nvpunk.preferences').get_small_window_border(),
        source = 'always',
        header = '',
        prefix = '',
    },
}
vim.diagnostic.config(diagnostic_conf)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = require('nvpunk.preferences').get_small_window_border(),
})

vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = require('nvpunk.preferences').get_small_window_border(),
    })
