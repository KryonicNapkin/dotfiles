return {
    { 'petRUShka/vim-opencl' },
    { 'arrufat/vala.vim' },
    { 'tikhomirov/vim-glsl' },
    -- XML, HTML tag autoclosing (requires treesitter)
    -- doesn't work right now
    -- use { 'windwp/nvim-ts-autotag', requires = 'nvim-treesitter/nvim-treesitter' }
    -- For automatic code formatting
    { 'sbdchd/neoformat' },
    -- For hugo templating
    { 'phelipetls/vim-hugo' },

    -- support for astro
    {
        'wuelnerdotexe/vim-astro',
        lazy = true,
        config = function()
            vim.g.astro_typescrypt = 'enable'
            vim.g.astro_stylus = 'disable'
        end,
        ft = { 'astro' },
    },

    -- support for MDX
    { 'jxnblk/vim-mdx-js' },
}
