-- For quickly switching between camel and snake case etc
return {
    'arthurxavierx/vim-caser',
    lazy = true,
    keys = {
        { 'gs', mode = { 'n', 'v' }, desc = 'Change Case' },
        { 'gsm', mode = { 'n', 'v' }, desc = 'PascalCase' },
        { 'gsp', mode = { 'n', 'v' }, desc = 'PascalCase' },
        { 'gsc', mode = { 'n', 'v' }, desc = 'camelCase' },
        { 'gs_', mode = { 'n', 'v' }, desc = 'snake_case' },
        { 'gsu', mode = { 'n', 'v' }, desc = 'UPPER_CASE' },
        { 'gsU', mode = { 'n', 'v' }, desc = 'UPPER_CASE' },
        { 'gst', mode = { 'n', 'v' }, desc = 'Title Case' },
        { 'gss', mode = { 'n', 'v' }, desc = 'Sentence case' },
        { 'gs<space>', mode = { 'n', 'v' }, desc = 'space case' },
        { 'gs-', mode = { 'n', 'v' }, desc = 'kebab-case' },
        { 'gsk', mode = { 'n', 'v' }, desc = 'kebab-case' },
        { 'gsK', mode = { 'n', 'v' }, desc = 'Title-Kebab-Case' },
        { 'gs.', mode = { 'n', 'v' }, desc = 'dot.case' },
    },
}
