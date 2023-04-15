local PFX = 'nvpunk.plugins.tools.'
local plugins = {
    'notify',
    'telescope',
    'toggleterm',
    'dressing',
    'diffview',
}

return require('nvpunk.internals.functools').map(
    plugins,
    function(plugin) return require(PFX .. plugin) end
)
