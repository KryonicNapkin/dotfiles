local M = {}

local CONFIG_HOME = vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. '/.config')
local USER_CONF_DIR = CONFIG_HOME .. '/nvpunk'
local USER_CONF_INIT = USER_CONF_DIR .. '/lua/user/init.lua'
local USER_CONF_PLUGINS = USER_CONF_DIR .. '/lua/user/plugins.lua'
local USER_CONF_THEMES = USER_CONF_DIR .. '/lua/user/themes.lua'

M.export_user_conf_path = function()
    package.path = USER_CONF_DIR .. '/lua/?.lua;' .. package.path
end

local try_require = require('nvpunk.internals.try').require

M.user_init = function()
    if vim.fn.filereadable(USER_CONF_INIT) == 1 then try_require 'user.init' end
end

M.user_plugins = function()
    if vim.fn.filereadable(USER_CONF_PLUGINS) == 1 then
        local res = try_require 'user.plugins'
        if
            type(res) == 'table'
            and not vim.tbl_isempty(res)
            and vim.tbl_islist(res)
            and type(res[1]) == 'table'
        then
            return res
        end
    end
    return nil
end

M.user_themes = function()
    if vim.fn.filereadable(USER_CONF_THEMES) == 1 then
        local res = try_require 'user.themes'
        return type(res) == 'table' and res or {}
    end
    return {}
end

return M
