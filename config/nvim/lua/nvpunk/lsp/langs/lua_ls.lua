local lspconfig = require 'lspconfig'
local add_to_default = require('nvpunk.lsp.langs.default').add_to_default

return function()
    lspconfig['lua_ls'].setup(add_to_default {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = {
                        [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                        [vim.fn.stdpath 'config' .. '/lua'] = true,
                    },
                },
            },
        },
    })
end
