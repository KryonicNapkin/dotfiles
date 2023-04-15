require('nvpunk.internals.try').load_theme('monokai-soda', function()
    require('monokai').setup { palette = require('monokai').soda }
    reload 'nvpunk.theme_manager.lualine' 'auto' -- no monokai theme for lualine
end)
