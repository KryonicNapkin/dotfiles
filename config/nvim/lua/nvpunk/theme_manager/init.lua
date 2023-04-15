local M = {}

local theme = require('nvpunk.preferences').get_theme()

M.setup = function()
    vim.schedule(
        function()
            require('nvpunk.theme_manager.theme_chooser').load_theme(
                theme,
                false,
                false
            )
        end
    )
end

return M
