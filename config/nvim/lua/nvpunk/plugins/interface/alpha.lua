-- greeter
return {
    'goolord/alpha-nvim',
    branch = 'main',
    config = function()
        local dashboard = require 'alpha.themes.dashboard'

        local header =
            require('nvpunk.internals.greeter_headers').images[require(
                'nvpunk.preferences'
            ).get_greeter()]

        dashboard.section.header.val = header.content
        dashboard.section.header.opts.hl = header.hl

        local function button(sc, txt, cmd, hl)
            local b = dashboard.button(sc, txt, cmd)
            b.opts.hl = hl or 'Title'
            b.opts.hl_shortcut = 'Comment'
            return b
        end

        dashboard.section.buttons.val = {
            button('fn', '  New file', ':NvpunkNewFileDialog<CR>'),
            button('ge', '  Open explorer', ':NvpunkExplorerToggle<CR>'),
            button(
                'tf',
                '  Find file',
                ':lua require"nvpunk.internals.telescope_pickers".find_files()<CR>'
            ),
            button(
                'tg',
                '  Find word',
                ':lua require"nvpunk.internals.telescope_pickers".live_grep()<CR>'
            ),
            button(
                'th',
                '  Recent files',
                ':lua require"telescope.builtin".oldfiles()<CR>'
            ),
            { type = 'padding', val = 1 },
            button('M', '  Mason Package Manager', ':Mason<CR>'),
            button(
                'C',
                '  Preferences',
                ':lua require"nvpunk.preferences".preferences_menu()<CR>'
            ),
            button('cu', '  Update Plugins', ':Lazy restore<CR>'),
            button(
                'cU',
                '  Update Nvpunk',
                ':lua require"nvpunk.punk_funcs".nvpunk_update()<CR>'
            ),
            button(
                'ch',
                '  Health Check',
                ':lua require"nvpunk.internals.healthcheck"()<CR>'
            ),
            button('H', 'ﬤ  Nvpunk Documentation', ':h nvpunk<CR>'),
            { type = 'padding', val = 1 },
            button('q', '  Quit', ':qa<CR>', 'NvpunkRed'),
        }

        local function get_nvpunk_version()
            return '#'
                .. vim.trim(
                    vim.split(
                        vim.api.nvim_exec(
                            '!git -C "'
                                .. vim.fn.stdpath 'config'
                                .. '" describe --always',
                            true
                        ),
                        '\r'
                    )[2]
                )
        end

        local function get_neovim_version()
            local v = vim.version()
            return 'v'
                .. tostring(v.major)
                .. '.'
                .. tostring(v.minor)
                .. '.'
                .. tostring(v.patch)
        end

        dashboard.section.footer.val = ' Nvpunk '
            .. get_nvpunk_version()
            .. '    Neovim '
            .. get_neovim_version()
        dashboard.section.footer.opts.hl = 'Comment'

        dashboard.config.layout = {
            { type = 'padding', val = 3 },
            dashboard.section.header,
            { type = 'padding', val = 2 },
            dashboard.section.buttons,
            { type = 'padding', val = 2 },
            dashboard.section.footer,
        }

        dashboard.section.buttons.opts.spacing = 0
        require('alpha').setup(dashboard.opts)

        require('nvpunk.internals.keymapper').nkeymap(
            '<leader>A',
            '<CMD>Alpha<CR>',
            ' Open Greeter'
        )
    end,
}
