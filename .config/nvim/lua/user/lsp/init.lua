local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
   return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.arduino_language_server.setup({
    capabilities = capabilities,
    cmd = {
        "arduino-language-server",
        "-cli-config",
        "$HOME/.arduino15/arduino-cli.yaml",
        "-fqbn",
        "arduino:avr:mega"
    }
})
require "user.lsp.mason"
require("user.lsp.handlers").setup()
