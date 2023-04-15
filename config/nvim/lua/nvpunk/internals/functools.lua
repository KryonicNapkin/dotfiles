local M = {}

--- Functional map
---@param list any[]
---@param func function
---@return any[]
M.map = function(list, func)
    local res = {}
    for _, v in ipairs(list) do
        table.insert(res, func(v))
    end
    return res
end

--- Functional map
---@param list any[]
---@param func function
---@return any[]
M.filter = function(list, func)
    local res = {}
    for _, v in ipairs(list) do
        if func(v) then table.insert(res, v) end
    end
    return res
end

return M
