local function _assign(old, new, k)
    -- local otype = type(old[k])
    -- local ntype = type(new[k])
    -- if (otype == 'thread' or otype == 'userdata') or
    --     (ntype == 'thread' or ntype == 'userdata')
    -- then
    -- WARN old or new attr type is thread or userdata
    -- end
    old[k] = new[k]
end

local function _replace(old, new, repeat_tbl)
    if repeat_tbl[old] then return end
    repeat_tbl[old] = true

    local dellist = {}
    for k, _ in pairs(old) do
        if not new[k] then table.insert(dellist, k) end
    end

    for _, v in ipairs(dellist) do
        old[v] = nil
    end

    for k, _ in pairs(new) do
        if not old[k] then
            old[k] = new[k]
        else
            if type(old[k]) ~= type(new[k]) then
                -- WARN old type doesn't match new type
                _assign(old, new, k)
            else
                if type(old) == 'table' then
                    _replace(old[k], new[k], repeat_tbl)
                else
                    _assign(old, new, k)
                end
            end
        end
    end
end

--- Reload a module
---@param mod string
---@return any
return function(mod)
    if not package.loaded[mod] then
        local m = require(mod)
        return m
    end
    local old = package.loaded[mod]
    package.loaded[mod] = nil

    local new = require(mod)

    if type(old) == 'table' and type(new) == 'table' then
        local repeat_tbl = {}
        _replace(old, new, repeat_tbl)
    end

    package.loaded[mod] = old
    return old
end
