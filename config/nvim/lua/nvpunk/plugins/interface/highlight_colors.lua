-- color preview
return {
    'brenoprata10/nvim-highlight-colors',
    config = function()
        require('nvim-highlight-colors').setup {
            -- 'background' | 'foreground' | 'first_column'
            render = 'background',
            enable_tailwind = false,
        }
    end,
}
