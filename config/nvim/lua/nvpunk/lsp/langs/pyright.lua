local lspconfig = require 'lspconfig'
local add_to_default = require('nvpunk.lsp.langs.default').add_to_default

local gistubgen_out_path = vim.fn.expand '$HOME/git/gi-stubgen/out'
if not vim.fn.isdirectory(gistubgen_out_path) then gistubgen_out_path = '' end

return function()
    lspconfig['pyright'].setup(add_to_default {
        settings = {
            python = {
                analysis = {
                    stubPath = gistubgen_out_path,
                },
            },
        },
    })
end
