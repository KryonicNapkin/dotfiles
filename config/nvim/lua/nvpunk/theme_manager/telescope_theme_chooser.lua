local load_theme = require('nvpunk.theme_manager.theme_chooser').load_theme
local themes = require('nvpunk.theme_manager.theme_chooser').available_themes

local T = {
    utils = require 'telescope.utils',
    previewers = require 'telescope.previewers',
    config = require('telescope.config').values,
    pickers = require 'telescope.pickers',
    finders = require 'telescope.finders',
    themes = require 'telescope.themes',
    actions = require 'telescope.actions',
}

return function()
    -- loosely based on:
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__internal.lua#L926
    local prev_theme = require('nvpunk.preferences').get_theme()
    local needs_restore = true

    local bufnr = vim.api.nvim_get_current_buf()
    local p = vim.api.nvim_buf_get_name(bufnr)
    local demo_win = nil
    local close_demo_win = false

    if vim.fn.buflisted(bufnr) ~= 1 then
        vim.cmd(
            'tabedit '
                .. vim.fn.stdpath 'config'
                .. '/lua/nvpunk/theme_manager/telescope_theme_chooser.lua'
        )
        bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
        p = vim.api.nvim_buf_get_name(bufnr)
        demo_win = vim.api.nvim_get_current_win()
        close_demo_win = true
    end

    local previewer = T.previewers.new_buffer_previewer {
        get_buffer_by_name = function() return p end,
        define_preview = function(self, entry)
            if vim.loop.fs_stat(p) then
                T.config.buffer_previewer_maker(
                    p,
                    self.state.bufnr,
                    { bufname = self.state.bufname }
                )
            else
                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                vim.api.nvim_buf_set_lines(
                    self.state.bufnr,
                    0,
                    -1,
                    false,
                    lines
                )
            end
            load_theme(entry.value, false, false)
        end,
    }

    local function reset()
        if needs_restore then
            load_theme(prev_theme, false, false)
            needs_restore = false
        end
        if close_demo_win and demo_win ~= nil then
            vim.api.nvim_win_close(demo_win, true)
            close_demo_win = false
        end
        vim.cmd 'stopinsert'
    end

    local picker = T.pickers.new({}, {
        prompt_title = 'Choose a theme:',
        finder = T.finders.new_table {
            results = themes,
        },
        sorter = T.config.generic_sorter {},
        previewer = previewer,
        attach_mappings = function(_)
            T.actions.select_default:replace(function(prompt_bufnr)
                local selection =
                    require('telescope.actions.state').get_selected_entry()
                if selection == nil then
                    T.utils.__warn_no_selection 'nvpunk.theme_selector'
                    T.actions.close(prompt_bufnr)
                    reset()
                    return
                end

                needs_restore = false
                T.actions.close(prompt_bufnr)
                load_theme(selection.value)
                reset()
            end)

            return true
        end,
    })

    local close_wins = picker.close_windows
    picker.close_windows = function(status)
        close_wins(status)
        reset()
    end

    picker:find()
end
