-- completion
return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        -- lua based snippets
        {
            'L3MON4D3/LuaSnip',
            dependencies = {
                'rafamadriz/friendly-snippets',
            },
            version = '1.*',
            build = 'make install_jsregexp',
        },
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'lukas-reineke/cmp-under-comparator',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-emoji',
        'chrisgrieser/cmp-nerdfont',
    },
    config = function()
        -- tab/s-tab utility functions
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0
                and vim.api
                        .nvim_buf_get_lines(0, line - 1, line, true)[1]
                        :sub(col, col)
                        :match '%s'
                    == nil
        end

        local cmp = require 'cmp'
        local luasnip = require 'luasnip'

        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup {
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                -- enter accepts the current selection
                -- `select=false`: only accept if there is a selection
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_selected_entry() then
                        cmp.confirm()
                    elseif cmp.visible() then
                        cmp.close()
                    else
                        fallback()
                    end
                end),
                -- ['<CR>'] = cmp.mapping.confirm({select=false}),
                ['<C-Space>'] = cmp.mapping(
                    cmp.mapping.complete(),
                    { 'i', 'c' }
                ),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        -- The fallback function sends a already mapped key.
                        -- In this case, it's probably `<Tab>`.
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
                -- close completion menu on esc...
                -- ['<Esc>'] = cmp.mapping(function(fallback)
                --     -- ...if visible...
                --     if cmp.visible() then
                --         cmp.close()
                --     -- ...else emit esc
                --     else
                --         fallback()
                --     end
                -- end)
            },
            sources = cmp.config.sources {
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
                { name = 'calc' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'emoji' },
                { name = 'nerdfont' },
            },
            formatting = {
                -- icons in completions
                format = require('lspkind').cmp_format {
                    mode = 'symbol_text',
                    preset = 'codicons',
                    maxwidth = 50,
                },
            },
            -- don't sort double underscore things first
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    require('cmp-under-comparator').under,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            window = {
                completion = cmp.config.window.bordered {
                    border = require('nvpunk.preferences').get_popup_border(),
                    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
                },
                documentation = cmp.config.window.bordered {
                    border = require('nvpunk.preferences').get_small_window_border(),
                    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
                },
            },
            experimental = {
                ghost_text = false,
            },
        }

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'cmdline' },
            },
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })
    end,
}
