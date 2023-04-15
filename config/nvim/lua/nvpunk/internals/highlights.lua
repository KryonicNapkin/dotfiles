local M = {}

M.HC_HEADER = 'NvpunkHealthcheckHeader'
M.HC_GOOD = 'NvpunkHealthcheckGood'
M.HC_BAD = 'NvpunkHealthcheckBad'
M.RED = 'NvpunkRed'

-- shim for missing highlights
local function set_hl(name, existing)
    vim.api.nvim_set_hl(0, name, { link = existing })
end

M.setup = function()
    -- nvpunk specific
    vim.api.nvim_set_hl(0, M.HC_HEADER, {
        bg = '#f6c177',
        fg = '#191724',
        bold = true,
    })
    vim.api.nvim_set_hl(0, M.HC_GOOD, {
        fg = '#a6d189',
    })
    vim.api.nvim_set_hl(0, M.HC_BAD, {
        fg = '#eb6f92',
    })
    vim.api.nvim_set_hl(0, M.RED, {
        fg = '#eb6f92',
    })
end

return M
