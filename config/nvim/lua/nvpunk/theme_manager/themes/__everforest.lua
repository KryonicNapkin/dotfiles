--- Set everforest theme with specific style
---@param style 'soft' | 'medium' | 'hard'
---@param light boolean
return function(style, light)
    local t = require 'everforest'
    if light == true then
        vim.o.background = 'light'
    else
        vim.o.background = 'dark'
    end
    t.setup {
        background = style,
    }
    vim.cmd 'colorscheme everforest'
    reload 'nvpunk.theme_manager.lualine' 'auto'
end
