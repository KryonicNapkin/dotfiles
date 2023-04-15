local M = {}

M.find_files = function()
    require('telescope.builtin').find_files(
        require('telescope.themes').get_dropdown { previewer = false }
    )
end

M.live_grep = function() require('telescope.builtin').live_grep() end

M.oldfiles = function()
    require('telescope.builtin').oldfiles(
        require('telescope.themes').get_dropdown { previewer = false }
    )
end

M.lsp_references = function() require('telescope.builtin').lsp_references() end

return M
