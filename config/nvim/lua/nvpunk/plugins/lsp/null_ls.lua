-- Use Neovim as a language server to inject LSP diagnostics,
-- code actions, and more via Lua.
return {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
        local mason_null_ls = require 'mason-null-ls'
        local null_ls = require 'null-ls'

        local packages = {
            'stylua',
            'prettier',
            'alex',
        }

        if require('nvpunk.internals.cpu').is_x86_64() then
            table.insert(packages, 'jq')
        end

        mason_null_ls.setup {
            ensure_installed = packages,
            automatic_installation = true,
            automatic_setup = true,
        }

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        null_ls.setup {
            debug = true,
            sources = {
                formatting.stylua.with {
                    extra_args = {
                        '--quote-style',
                        'ForceSingle',
                        '--indent-width',
                        '4',
                        '--column-width',
                        '80',
                    },
                },
                formatting.black,
                formatting.prettier,
                -- diagnostics.eslint,
                diagnostics.flake8,
                -- null_ls.builtins.completion.spell,
            },
            on_init = function(new_client, _)
                new_client.offset_encoding = 'utf-8'
            end,
        }

        mason_null_ls.setup_handlers()
    end,
    priority = 30,
}
