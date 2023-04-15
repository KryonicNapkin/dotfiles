require('nvpunk.internals.try').load_theme('nordic', function()
    vim.cmd 'colorscheme nordic'
    reload 'nvpunk.theme_manager.lualine' 'nordic'
end)
