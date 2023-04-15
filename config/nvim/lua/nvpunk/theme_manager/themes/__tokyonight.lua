--- Set tokyonight theme with specific style
---@param style 'storm' | 'night' | 'moon' | 'day'
return function(style)
    if style == 'day' then
        vim.o.background = 'light'
    else
        vim.o.background = 'dark'
    end
    vim.g.tokyonight_style = style
    vim.g.tokyonight_sidebars = {
        'NvimTree',
        'aerial',
        'neo-tree',
    }
    vim.g.tokyonight_dark_sidebar = true
    require('tokyonight').setup {
        style = style,
        light_style = 'day',
        transparent = false,
        terminal_colors = true,
        styles = {
            sidebars = 'dark',
            floats = 'dark',
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
        },
        sidebars = { 'qf', 'NvimTree', 'aerial', 'neo-tree', 'help' },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
    }
    vim.cmd 'colorscheme tokyonight'
    reload 'nvpunk.theme_manager.lualine' 'tokyonight'
end
