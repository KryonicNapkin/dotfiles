--- Set catpuccin theme with specific style
---@param style 'macchiato' | 'latte' | 'frappe' | 'macchiato' | 'mocha'
return function(style)
    if style == 'latte' then
        vim.o.background = 'light'
    else
        vim.o.background = 'dark'
    end
    local t = require 'catppuccin'
    t.setup {
        flavour = style,
        dim_inactive = {
            enabled = false,
            shade = 'dark',
            percentage = 0.15,
        },
        term_colors = true,
        styles = {
            comments = { 'italic' },
            conditionals = { 'italic' },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
            },
            coc_nvim = false,
            lsp_trouble = true,
            cmp = true,
            lsp_saga = true,
            gitgutter = true,
            gitsigns = true,
            telescope = true,
            nvimtree = true,
            neotree = true,
            dap = {
                enabled = true,
                enable_ui = true,
            },
            which_key = true,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },
            dashboard = false,
            neogit = false,
            vim_sneak = false,
            fern = false,
            markdown = true,
            lightspeed = false,
            ts_rainbow = false,
            hop = false,
            mason = true,
            notify = true,
            symbols_outline = true,
            mini = true,
            vimwiki = false,
            beacon = false,
            navic = { enabled = true, custom_bg = 'NONE' },
            overseer = false,
            aerial = true,
        },
    }
    vim.cmd 'colorscheme catppuccin'
    vim.cmd('Catppuccin ' .. style)
    reload 'nvpunk.theme_manager.lualine' 'catppuccin'
end
