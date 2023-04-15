-- show which key does what in long key combos
return {
    'folke/which-key.nvim',
    config = function()
        require('which-key').setup {
            icons = {
                -- symbol used in the command line area that shows your active key combo
                breadcrumb = '»',
                -- symbol used between a key and it's label
                separator = '➜',
                -- symbol prepended to a group
                group = '…',
            },
            spelling = { enabled = true, suggestions = 20 },
        }
    end,
    priority = 9999,
}
