local M = {}

local mappings = {
    ['<cr>'] = 'activate_line',
    q = 'close_win',
    ['<esc>'] = 'close_win',
}

M.bufs = {}
M.wins = {}
M.line_cmds = {}

M.__keybinds = {
    activate_line = function(_)
        local c = M.line_cmds[vim.api.nvim_get_current_line()]
        if c ~= nil then c() end
    end,
    close_win = function(bname) M.close_win(bname) end,
}

--- Get the size of the whole nvim window
---@return integer width
---@return integer height
M.get_nvim_size = function()
    local w = vim.api.nvim_get_option 'columns'
    local h = vim.api.nvim_get_option 'lines'

    return w, h
end

local function set_keymaps(bname)
    for k, v in pairs(mappings) do
        vim.api.nvim_buf_set_keymap(
            M.bufs[bname],
            'n',
            k,
            '<cmd>lua require"nvpunk.internals.float".__keybinds.'
                .. v
                .. '("'
                .. bname
                .. '")<cr>',
            { nowait = true, noremap = true, silent = true }
        )
    end
end

M.open_win = function(bname)
    local vim_w, vim_h = M.get_nvim_size()
    local win_w = math.ceil(vim_w * 0.8)
    local win_h = math.ceil(vim_h * 0.8 - 4)

    local x = math.ceil((vim_w - win_w) / 2)
    local y = math.ceil((vim_h - win_h) / 2 - 1)

    local opts = {
        style = 'minimal',
        relative = 'editor',
        width = win_w,
        height = win_h,
        row = y,
        col = x,
        border = require('nvpunk.preferences').get_window_border(),
    }
    M.wins[bname] = vim.api.nvim_open_win(M.bufs[bname], true, opts)
    vim.api.nvim_win_set_option(M.wins[bname], 'wrap', false)
    vim.api.nvim_win_set_option(M.wins[bname], 'cursorline', true)
    vim.api.nvim_win_set_option(
        M.wins[bname],
        'winhighlight',
        'CursorLine:Visual'
    )
end

local function make_buf_name(bname) return bname .. ' #' .. M.bufs[bname] end

--- Open a float window, return its buffer and window
---@param bname string
---@return integer buffer
---@return integer window
M.create_win = function(bname)
    M.bufs[bname] = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(M.bufs[bname], make_buf_name(bname))
    vim.api.nvim_buf_set_option(M.bufs[bname], 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(M.bufs[bname], 'modifiable', false)
    vim.api.nvim_buf_set_option(M.bufs[bname], 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(M.bufs[bname], 'swapfile', false)
    vim.api.nvim_buf_set_option(M.bufs[bname], 'filetype', 'Nvpunk')
    set_keymaps(bname)

    M.open_win(bname)

    return M.bufs[bname], M.wins[bname]
end

--- Draws the given messages in the window
---@param bname string name of the buffer
---@param lines table<{message:string, hl?:string, cmd?: string}>
M.draw = function(bname, lines)
    M.clear_win(bname)
    vim.api.nvim_buf_set_option(M.bufs[bname], 'modifiable', true)
    for i, v in ipairs(lines) do
        vim.api.nvim_buf_set_lines(
            M.bufs[bname],
            i - 1,
            i,
            false,
            { v.message }
        )
        if v.cmd ~= nil then M.line_cmds[v.message] = v.cmd end
        if v.hl ~= nil then
            vim.api.nvim_buf_add_highlight(
                M.bufs[bname],
                -1,
                v.hl,
                i - 1,
                0,
                -1
            )
        end
    end
    vim.api.nvim_buf_set_option(M.bufs[bname], 'modifiable', false)
end

M.clear_win = function(bname)
    vim.api.nvim_buf_set_option(M.bufs[bname], 'modifiable', true)
    vim.api.nvim_buf_set_lines(M.bufs[bname], 0, -1, false, { '' })
    vim.api.nvim_buf_set_option(M.bufs[bname], 'modifiable', false)
end

M.close_win = function(bname) vim.api.nvim_win_close(M.wins[bname], true) end

return M
