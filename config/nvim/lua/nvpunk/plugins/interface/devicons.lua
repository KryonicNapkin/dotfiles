-- icons
return {
    'kyazdani42/nvim-web-devicons',
    dependencies = {
        'ryanoasis/vim-devicons',
    },
    lazy = true,
    init = function() vim.g.WebDevIconsUnicodeGlyphDoubleWidth = 1 end,
    config = function()
        require('nvim-web-devicons').setup {
            override = {
                ['meson.build'] = {
                    icon = '',
                    color = '#6d8086',
                    name = 'Meson',
                },
                ['meson_options.txt'] = {
                    icon = '',
                    color = '#6d8086',
                    name = 'MesonOptions',
                },
                ['vert'] = { -- glsl vertex shader
                    icon = '',
                    color = '#2ec27e',
                    name = 'Vertex',
                },
                ['frag'] = { -- glsl fragment shader
                    icon = '',
                    color = '#2ec27e',
                    name = 'Fragment',
                },
                ['geom'] = { -- glsl geometry shader
                    icon = '',
                    color = '#2ec27e',
                    name = 'Geometry',
                },
                ['spv'] = {
                    icon = '',
                    color = '#41535b',
                    name = 'SpirV',
                },
                ['o'] = {
                    icon = '',
                    color = '#41535b',
                    name = 'COutput',
                },
                ['ui'] = {
                    icon = '',
                    color = '#1c71d8',
                    name = 'GtkUI',
                },
                ['blp'] = {
                    icon = '',
                    color = '#1c71d8',
                    name = 'Blueprint',
                },
                ['astro'] = {
                    icon = '',
                    color = '#1c71d8',
                    name = 'Astro',
                },
            },
            default = true,
        }
    end,
}
