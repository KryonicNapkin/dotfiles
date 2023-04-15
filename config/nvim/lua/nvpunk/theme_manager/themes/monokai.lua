require('nvpunk.internals.try').load_theme('monokai', function()
    require('monokai').setup {}
    reload 'nvpunk.theme_manager.lualine' 'auto' -- no monokai theme for lualine
end)
