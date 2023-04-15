local M = {}

--- Call a function; show a notification if it fails
---@param func function
---@param args table
---@param err? string
---@param context? string
M.call = function(func, args, err, context)
    if err == nil then err = 'Failed to call function' end
    if context == nil then context = 'nvpunk.try.call' end
    local ok, res = pcall(func, unpack(args))
    if not ok then
        vim.notify(err, vim.log.levels.ERROR, { title = context })
    end
    return res
end

--- Try to call require; show a notification if it fails
---@param module string
M.require = function(module)
    return M.call(
        require,
        { module },
        'Failed to load module ' .. module,
        'nvpunk.try.require'
    )
end

--- Try to load theme, show an error notification on fail
--- If loader is nil, it will call vim.cmd('colorscheme ' .. name)
---@param name string
---@param loader? function
M.load_theme = function(name, loader)
    if loader == nil then
        loader = function() vim.cmd('colorscheme ' .. name) end
    end
    M.call(loader, {}, 'Failed to load theme ' .. name, 'nvpunk.theme_manager')
end

return M
