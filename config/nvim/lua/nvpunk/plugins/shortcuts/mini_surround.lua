-- for surrounding text with delimiters such as brackets and quotes
return {
    'echasnovski/mini.surround',
    lazy = true,
    config = function()
        require('mini.surround').setup {
            custom_surroundings = nil,
            highlight_duration = 500,
            mappings = {
                add = 'S',
                delete = '<space>Sd',
                find = '<space>Sf',
                find_left = '<space>SF',
                highlight = '<space>Sh',
                replace = '<space>Sc',
                update_n_lines = '<space>Sn',
            },
            n_lines = 20,
            search_method = 'cover',
        }
    end,
    keys = {
        { 'S', mode = 'v', desc = ' Surround' },
        { '<leader>S', mode = { 'n', 'v' }, desc = ' Surround' },
        { '<leader>Sd', mode = { 'n', 'v' }, desc = 'Delete' },
        { '<leader>Sf', mode = { 'n', 'v' }, desc = 'Find Forward' },
        { '<leader>SF', mode = { 'n', 'v' }, desc = 'Find Back' },
        { '<leader>Sh', mode = { 'n', 'v' }, desc = 'Highlight' },
        { '<leader>Sc', mode = { 'n', 'v' }, desc = 'Replace' },
        { '<leader>Sn', mode = { 'n', 'v' }, desc = 'Update 20 lines' },
    },
}
