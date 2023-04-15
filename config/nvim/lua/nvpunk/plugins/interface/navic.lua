-- breadcrumbs
return {
    'SmiteshP/nvim-navic',
    config = function()
        require('nvim-navic').setup {
            icons = {
                File = ' ',
                Module = ' ',
                Namespace = ' ',
                Package = ' ',
                Class = ' ',
                Method = ' ',
                Property = ' ',
                Field = ' ',
                Constructor = ' ',
                Enum = '練',
                Interface = '練',
                Function = ' ',
                Variable = ' ',
                Constant = ' ',
                String = ' ',
                Number = ' ',
                Boolean = '◩ ',
                Array = ' ',
                Object = ' ',
                Key = ' ',
                Null = 'ﳠ ',
                EnumMember = ' ',
                Struct = ' ',
                Event = ' ',
                Operator = ' ',
                TypeParameter = ' ',
            },
            highlight = true,
            separator = ' ',
            depth_limit = 0,
            depth_limit_indicator = '…',
            safe_output = true,
        }
        vim.api.nvim_create_autocmd(
            { 'BufEnter', 'LspAttach', 'User LspProgressUpdate' },
            {
                callback = function()
                    if
                        require('nvpunk.preferences').get_navic_enabled()
                        and require('nvim-navic').is_available()
                    then
                        vim.wo.winbar =
                            "%{%v:lua.require'nvim-navic'.get_location()%}"
                    else
                        vim.wo.winbar = ''
                    end
                end,
            }
        )
    end,
}
