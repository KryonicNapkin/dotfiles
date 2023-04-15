--- Set onedark theme with specific style
---@param style 'dark' | 'darker' | 'cool' | 'deep' | 'warm' | 'warmer'
return function(style)
    local t = require 'onedark'
    t.setup {
        style = style,
    }
    t.load()
    reload 'nvpunk.theme_manager.lualine' 'onedark'
end
