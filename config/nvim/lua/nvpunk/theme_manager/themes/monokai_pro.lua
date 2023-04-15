require('nvpunk.internals.try').load_theme('monokai-pro', function()
    require('monokai').setup { palette = require('monokai').pro }
    reload 'nvpunk.theme_manager.lualine' 'auto' -- no monokai theme for lualine
end)
