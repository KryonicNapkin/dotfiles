require('nvpunk.internals.try').load_theme('monokai-ristretto', function()
    require('monokai').setup { palette = require('monokai').ristretto }
    reload 'nvpunk.theme_manager.lualine' 'auto' -- no monokai theme for lualine
end)
