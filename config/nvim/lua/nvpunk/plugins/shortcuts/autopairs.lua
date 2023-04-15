-- auto insert matching brackets and quotes
return {
    'windwp/nvim-autopairs',
    config = function()
        require('nvim-autopairs').setup {
            check_ts = true,
            disable_filetype = require 'nvpunk.internals.nonfile_buffers',
        }

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        local cmp = require 'cmp'
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done { map_char = { tex = '' } }
        )
    end,
}
