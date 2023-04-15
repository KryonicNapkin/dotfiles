-- nice diffview
return {
    'sindrets/diffview.nvim',
    lazy = true,
    config = function()
        local actions = require 'diffview.actions'
        require('diffview').setup {
            keymaps = {
                disable_defaults = true,
                file_panel = {
                    {
                        'n',
                        'j',
                        actions.next_entry,
                        { desc = 'Bring the cursor to the next file entry' },
                    },
                    {
                        'n',
                        '<down>',
                        actions.next_entry,
                        { desc = 'Bring the cursor to the next file entry' },
                    },
                    {
                        'n',
                        'k',
                        actions.prev_entry,
                        {
                            desc = 'Bring the cursor to the previous file entry.',
                        },
                    },
                    {
                        'n',
                        '<up>',
                        actions.prev_entry,
                        {
                            desc = 'Bring the cursor to the previous file entry.',
                        },
                    },
                    {
                        'n',
                        '<cr>',
                        actions.select_entry,
                        { desc = 'Open the diff for the selected entry.' },
                    },
                    {
                        'n',
                        '<2-LeftMouse>',
                        actions.select_entry,
                        { desc = 'Open the diff for the selected entry.' },
                    },
                    {
                        'n',
                        'L',
                        actions.open_commit_log,
                        { desc = 'Open the commit log panel.' },
                    },
                    {
                        'n',
                        '<c-b>',
                        actions.scroll_view(-0.25),
                        { desc = 'Scroll the view up' },
                    },
                    {
                        'n',
                        '<c-f>',
                        actions.scroll_view(0.25),
                        { desc = 'Scroll the view down' },
                    },
                    {
                        'n',
                        '<tab>',
                        actions.select_next_entry,
                        { desc = 'Open the diff for the next file' },
                    },
                    {
                        'n',
                        '<s-tab>',
                        actions.select_prev_entry,
                        { desc = 'Open the diff for the previous file' },
                    },
                    {
                        'n',
                        'i',
                        actions.listing_style,
                        { desc = "Toggle between 'list' and 'tree' views" },
                    },
                    {
                        'n',
                        '[x',
                        actions.prev_conflict,
                        { desc = 'Go to the previous conflict' },
                    },
                    {
                        'n',
                        ']x',
                        actions.next_conflict,
                        { desc = 'Go to the next conflict' },
                    },
                    {
                        'n',
                        '?',
                        actions.help 'file_panel',
                        { desc = 'Open the help panel' },
                    },
                },
                diff1 = {
                    -- Mappings in single window diff layouts
                    {
                        'n',
                        '?',
                        actions.help { 'view', 'diff1' },
                        { desc = 'Open the help panel' },
                    },
                },
                diff2 = {
                    -- Mappings in 2-way diff layouts
                    {
                        'n',
                        '?',
                        actions.help { 'view', 'diff2' },
                        { desc = 'Open the help panel' },
                    },
                },
                diff3 = {
                    -- Mappings in 3-way diff layouts
                    {
                        { 'n', 'x' },
                        '2do',
                        actions.diffget 'ours',
                        {
                            desc = 'Obtain the diff hunk from the OURS version of the file',
                        },
                    },
                    {
                        { 'n', 'x' },
                        '3do',
                        actions.diffget 'theirs',
                        {
                            desc = 'Obtain the diff hunk from the THEIRS version of the file',
                        },
                    },
                    {
                        'n',
                        '?',
                        actions.help { 'view', 'diff3' },
                        { desc = 'Open the help panel' },
                    },
                },
                diff4 = {
                    -- Mappings in 4-way diff layouts
                    {
                        { 'n', 'x' },
                        '1do',
                        actions.diffget 'base',
                        {
                            desc = 'Obtain the diff hunk from the BASE version of the file',
                        },
                    },
                    {
                        { 'n', 'x' },
                        '2do',
                        actions.diffget 'ours',
                        {
                            desc = 'Obtain the diff hunk from the OURS version of the file',
                        },
                    },
                    {
                        { 'n', 'x' },
                        '3do',
                        actions.diffget 'theirs',
                        {
                            desc = 'Obtain the diff hunk from the THEIRS version of the file',
                        },
                    },
                    {
                        'n',
                        '?',
                        actions.help { 'view', 'diff4' },
                        { desc = 'Open the help panel' },
                    },
                },
                option_panel = {
                    {
                        'n',
                        'q',
                        actions.close,
                        { desc = 'Close the panel' },
                    },
                    {
                        'n',
                        '?',
                        actions.help 'option_panel',
                        { desc = 'Open the help panel' },
                    },
                },
                help_panel = {
                    {
                        'n',
                        'q',
                        actions.close,
                        { desc = 'Close help menu' },
                    },
                    {
                        'n',
                        '<esc>',
                        actions.close,
                        { desc = 'Close help menu' },
                    },
                },
            },
        }
    end,
    keys = {
        { '<leader>?', desc = ' Diff View' },
        { '<leader>?o', '<cmd>DiffviewOpen<cr>', desc = 'DiffviewOpen' },
        { '<leader>?c', '<cmd>DiffviewClose<cr>', desc = 'DiffviewClose' },
        { '<leader>?r', '<cmd>DiffviewRefresh<cr>', desc = 'DiffviewRefresh' },
        {
            '<leader>?f',
            '<cmd>DiffviewToggleFiles<cr>',
            desc = 'DiffviewToggleFiles',
        },

        {
            '<leader>?0',
            '<cmd>DiffviewOpen HEAD<cr>',
            desc = 'DiffviewOpen HEAD',
        },
        {
            '<leader>?1',
            '<cmd>DiffviewOpen HEAD^<cr>',
            desc = 'DiffviewOpen HEAD^',
        },
        {
            '<leader>?2',
            '<cmd>DiffviewOpen HEAD^^<cr>',
            desc = 'DiffviewOpen HEAD^^',
        },
        {
            '<leader>?3',
            '<cmd>DiffviewOpen HEAD^^^<cr>',
            desc = 'DiffviewOpen HEAD^^^',
        },
        {
            '<leader>?4',
            '<cmd>DiffviewOpen HEAD^^^^<cr>',
            desc = 'DiffviewOpen HEAD^^^^',
        },

        {
            '<leader>?H',
            '<cmd>h nvpunk-shortcuts-diffview<cr>',
            desc = 'Show Shortcuts',
        },
    },
    cmd = {
        'DiffviewLog',
        'DiffviewOpen',
        'DiffviewClose',
        'DiffviewRefresh',
        'DiffviewFocusFiles',
        'DiffviewFileHistory',
        'DiffviewToggleFiles',
    },
}
