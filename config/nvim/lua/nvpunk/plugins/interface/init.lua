local PFX = 'nvpunk.plugins.interface.'
local plugins = {
    'devicons',
    'whichkey',
    'treesitter',
    'alpha',
    'bqf',
    'bufferline',
    'gitsigns',
    'highlight_colors',
    'indent_blankline',
    'lualine',
    'navic',
    'neotree',
    'ufo',
}

return require('nvpunk.internals.functools').map(
    plugins,
    function(plugin) return require(PFX .. plugin) end
)
