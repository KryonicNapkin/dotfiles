return {
    'mfussenegger/nvim-dap',
    config = function() require 'dap' end,
    lazy = true,
    keys = {
        { '<leader>b', desc = ' Debug' },
        {
            '<leader>bb',
            '<cmd>lua require"dap".toggle_breakpoint()<cr>',
            desc = 'Toggle Breakpoint',
        },
        {
            '<leader>bc',
            '<cmd>lua require"dap".continue()<cr>',
            desc = 'Continue',
        },
        { '<leader>bl', '<cmd>DapShowLog<cr>', desc = 'Show Log' },
        {
            '<leader>br',
            '<cmd>lua require"dap".repl.toggle()<cr>',
            desc = 'Toggle Repl',
        },
        {
            '<leader>bO',
            '<cmd>lua require"dap".step_out()<cr>',
            desc = 'Step Out',
        },
        {
            '<leader>bi',
            '<cmd>lua require"dap".step_into()<cr>',
            desc = 'Step Into',
        },
        {
            '<leader>bo',
            '<cmd>lua require"dap".step_over()<cr>',
            desc = 'Step Over',
        },
        {
            '<leader>bk',
            '<cmd>lua require"dap".terminate()<cr>',
            desc = 'Terminate',
        },
    },
    cmd = {
        'DapInstall',
        'DapShowLog',
        'DapStepOut',
        'DapContinue',
        'DapStepInto',
        'DapStepOver',
        'DapTerminate',
        'DapUninstall',
        'DapToggleRepl',
        'DapRestartFrame',
        'DapLoadLaunchJSON',
        'DapToggleBreakpoint',
    },
}
