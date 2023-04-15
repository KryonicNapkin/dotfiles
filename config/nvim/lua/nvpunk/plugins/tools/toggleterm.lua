-- toggle-able terminal (ctrl backslash)
return {
    'akinsho/toggleterm.nvim',
    config = function()
        require('toggleterm').setup {
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<C-\>]],
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = false,
            shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
            start_in_insert = true,
            insert_mappings = true, -- whether or not the open mapping applies in insert mode
            persist_size = true,
            direction = 'float',
            close_on_exit = true, -- close the terminal window when the process exits
            shell = vim.o.shell, -- change the default shell
            -- This field is only relevant if direction is set to 'float'
            highlights = {
                NormalFloat = { link = 'NormalFloat' },
                FloatBorder = { link = 'NormalFloat' },
            },
            float_opts = {
                border = require('nvpunk.preferences').get_window_border(),
            },
        }
    end,
    keys = {
        { [[<C-\>]], mode = { 'i', 'n' } },
    },
    cmd = {
        'ToggleTerm',
        'ToggleTermSetName',
        'ToggleTermToggleAll',
        'ToggleTermSendCurrentLine',
        'ToggleTermSendVisualLines',
        'ToggleTermSendVisualSelection',
    },
}