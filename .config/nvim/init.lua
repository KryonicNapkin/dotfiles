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

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("ColorizerToggle")
	end,
})

vim.g.arduino_serial_cmd = 'picocom {port} -b {baud} -l'
vim.opt.termguicolors = true
require("bufferline").setup{}
require("todo-comments").setup{}
vim.cmd('colorscheme onedark')
vim.cmd('set colorcolumn=80')
-- treesitter for c3 programming language 
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.c3 = {
  install_info = {
    url = "https://github.com/c3lang/tree-sitter-c3",
    files = {"src/parser.c", "src/scanner.c"},
    branch = "main",
  },
}

vim.diagnostic.config({ virtual_text = true })
