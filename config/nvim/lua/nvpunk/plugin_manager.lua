-- remove packer, remove in the future
require 'nvpunk.internals.rm_packer'()

-- bootstrap lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup 'nvpunk.plugins'

local function on_plugins_loaded()
    require'nvpunk.on_plugins_loaded'
end

vim.api.nvim_create_autocmd({ 'User VeryLazy' }, {
    callback = on_plugins_loaded,
    group = vim.api.nvim_create_augroup('OnLazyDone', { clear = true }),
})
