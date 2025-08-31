require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.lualine"
require "user.comment"
require "user.colorizer"

vim.g.arduino_serial_cmd = 'picocom {port} -b {baud} -l'
vim.opt.termguicolors = true
require("bufferline").setup{}
require("todo-comments").setup{}
vim.cmd('colorscheme onedark')
vim.cmd('set colorcolumn=80')
vim.opt.guicursor = "n-v-sm:block,i-c-ci-ve:block-blinkwait100-blinkon200-blinkoff500"

vim.diagnostic.config({ virtual_text = true })
