local user_plugins = require('nvpunk.internals.user_conf').user_plugins()

if user_plugins == nil then return {} end
return user_plugins
