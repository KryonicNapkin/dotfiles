-- pretty and better folding
return {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    init = function()
        local km = require 'nvpunk.internals.keymapper'

        -- blocked by: https://github.com/neovim/neovim/pull/17446
        -- vim.o.fillchars = [[eob: , fold: , foldopen:, foldsep: , foldclose:]]
        vim.o.foldcolumn = require('nvpunk.preferences').get_folding_guide_enabled()
                and '1'
            or '0'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`
        km.nkeymap('zR', function() require('ufo').openAllFolds() end)
        km.nkeymap('zM', function() require('ufo').closeAllFolds() end)
    end,
    config = function() require('ufo').setup() end,
}
