local M = {}

M.lsp_signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
}

M.dap_signs = {
    { name = 'DapBreakpoint', text = '', texthl = 'DiagnosticSignError' },
    {
        name = 'DapBreakpointRejected',
        text = '',
        texthl = 'DiagnosticSignWarn',
    },
    {
        name = 'DapStopped',
        text = '',
        texthl = 'GitSignsDelete',
        linehl = 'GitSignsDeleteLn',
    },
}

M.setup = function()
    local signs = {}
    vim.list_extend(signs, M.lsp_signs)
    vim.list_extend(signs, M.dap_signs)
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
            texthl = sign.texthl or sign.name,
            text = sign.text,
            numhl = sign.numl or '',
            linehl = sign.linehl or '',
        })
    end
end

return M
