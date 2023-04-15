return require('nvpunk.internals.functools').map({
    { 'AlexvZyl/nordic.nvim', branch = 'main' },
    { 'EdenEast/nightfox.nvim' },
    { 'Mofiqul/dracula.nvim' },
    { 'NTBBloodbath/doom-one.nvim' },
    { 'catppuccin/nvim', name = 'catppuccin' },
    { 'folke/tokyonight.nvim' },
    { 'kvrohit/mellow.nvim' },
    { 'luisiacc/gruvbox-baby' },
    { 'navarasu/onedark.nvim' },
    { 'neanias/everforest-nvim', branch = 'main' },
    { 'rebelot/kanagawa.nvim' },
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'sam4llis/nvim-tundra' },
    { 'shaunsingh/moonlight.nvim' },
    { 'shaunsingh/nord.nvim' },
    { 'tanvirtin/monokai.nvim' },
}, function(theme)
    theme.lazy = true
    return theme
end)
