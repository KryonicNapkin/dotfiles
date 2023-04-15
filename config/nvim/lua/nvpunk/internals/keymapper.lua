local M = {}

local keymap_opts = { noremap = true, silent = true }

--- Create keymap
---@param mode 'v' | 'x' | 'i' | 'n' | 't' | ''
---@param kb string
---@param cmd function | string
---@param desc? string
M.keymap = function(mode, kb, cmd, desc)
    local opts = keymap_opts
    if desc ~= nil then opts.desc = desc end
    vim.keymap.set(mode, kb, cmd, opts)
end

--- Create visual mode keymap
---@param kb string
---@param cmd function | string
---@param desc? string
M.vkeymap = function(kb, cmd, desc) M.keymap('v', kb, cmd, desc) end

--- Create visual/select mode mode keymap
---@param kb string
---@param cmd function | string
---@param desc? string
M.xkeymap = function(kb, cmd, desc) M.keymap('x', kb, cmd, desc) end

--- Create insert mode keymap
---@param kb string
---@param cmd function | string
---@param desc? string
M.ikeymap = function(kb, cmd, desc) M.keymap('i', kb, cmd, desc) end

--- Create normal mode keymap
---@param kb string
---@param cmd function | string
---@param desc? string
M.nkeymap = function(kb, cmd, desc) M.keymap('n', kb, cmd, desc) end

--- Create terminal mode keymap
---@param kb string
---@param cmd function | string
---@param desc? string
M.tkeymap = function(kb, cmd, desc) M.keymap('t', kb, cmd, desc) end

--- Create insert/normal mode keymap
---@param kb string
---@param cmd function | string
---@param desc? string
M.inkeymap = function(kb, cmd, desc)
    M.ikeymap(kb, cmd, desc)
    M.nkeymap(kb, cmd, desc)
end

--- Create a table of functions to create keymaps relative to the given buffer
---@param bufnr integer
---@return table[function]
M.create_bufkeymapper = function(bufnr)
    local bm = {}
    local buf_km_opts =
        vim.tbl_deep_extend('force', keymap_opts, { buffer = bufnr })

    --- Create keymap
    ---@param mode 'v' | 'x' | 'i' | 'n' | 't' | ''
    ---@param kb string
    ---@param cmd function | string
    ---@param desc? string
    bm.keymap = function(mode, kb, cmd, desc)
        local opts = buf_km_opts
        if desc ~= nil then opts.desc = desc end
        vim.keymap.set(mode, kb, cmd, opts)
    end

    --- Create visual mode keymap
    ---@param kb string
    ---@param cmd function | string
    ---@param desc? string
    bm.vkeymap = function(kb, cmd, desc) bm.keymap('v', kb, cmd, desc) end

    --- Create visual/select mode keymap
    ---@param kb string
    ---@param cmd function | string
    ---@param desc? string
    bm.xkeymap = function(kb, cmd, desc) bm.keymap('x', kb, cmd, desc) end

    --- Create insert mode keymap
    ---@param kb string
    ---@param cmd function | string
    ---@param desc? string
    bm.ikeymap = function(kb, cmd, desc) bm.keymap('i', kb, cmd, desc) end

    --- Create normal mode keymap
    ---@param kb string
    ---@param cmd function | string
    ---@param desc? string
    bm.nkeymap = function(kb, cmd, desc) bm.keymap('n', kb, cmd, desc) end

    --- Create terminal mode keymap
    ---@param kb string
    ---@param cmd function | string
    ---@param desc? string
    bm.tkeymap = function(kb, cmd, desc) bm.keymap('t', kb, cmd, desc) end

    --- Create insert/normal mode keymap
    ---@param kb string
    ---@param cmd function | string
    ---@param desc? string
    bm.inkeymap = function(kb, cmd, desc)
        bm.ikeymap(kb, cmd, desc)
        bm.nkeymap(kb, cmd, desc)
    end
    return bm
end

return M
