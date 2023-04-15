local PACKER_DIR = vim.fn.stdpath 'data' .. '/site/pack/packer'
local PACKER_COMPILED = vim.fn.stdpath 'config' .. '/plugin/packer_compiled.lua'

return function()
    if vim.fn.isdirectory(PACKER_DIR) then
        vim.fn.delete(PACKER_COMPILED, 'rf')
    end
    if vim.fn.filewritable(PACKER_COMPILED) then
        vim.fn.delete(PACKER_COMPILED)
    end
end
