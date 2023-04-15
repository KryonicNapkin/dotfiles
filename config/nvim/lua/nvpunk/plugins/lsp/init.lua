local PFX = 'nvpunk.plugins.lsp.'
local plugins = {
    'lspconfig',
    'aerial',
    'cmp',
    'fidget',
    'lsp_colors',
    'lspkind',
    'mason',
    'null_ls',
    'nvim_jdtls',
    'signature',
    'trouble',
}

return require('nvpunk.internals.functools').map(
    plugins,
    function(plugin) return require(PFX .. plugin) end
)
