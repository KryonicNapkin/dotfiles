local M = {}

--- Get current buffer size
---@return {width: number, height: number}
M.get_buf_size = function()
    local cbuf = vim.api.nvim_get_current_buf()
    local bufinfo = vim.tbl_filter(
        function(buf) return buf.bufnr == cbuf end,
        vim.fn.getwininfo(vim.api.nvim_get_current_win())
    )[1]
    if bufinfo == nil then return { width = -1, height = -1 } end
    return { width = bufinfo.width, height = bufinfo.height }
end

return M
