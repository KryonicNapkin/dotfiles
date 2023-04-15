local PFX = 'nvpunk.plugins.shortcuts.'
local plugins = {
    'comment',
    'autopairs',
    'mini_surround',
    'caser',
}

return require('nvpunk.internals.functools').map(
    plugins,
    function(plugin) return require(PFX .. plugin) end
)
