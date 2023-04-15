local M = {}

M.nvpunk_update = function()
    vim.notify('Updating Nvpunk...', vim.log.levels.INFO, {
        title = 'Nvpunk Update',
    })
    require('plenary.job')
        :new({
            command = '/usr/bin/git',
            args = {
                '-C',
                vim.fn.stdpath 'config',
                'pull',
            },
            on_exit = function(_, res)
                if res == 0 then
                    vim.notify('Nvpunk updated', vim.log.levels.INFO, {
                        title = 'Nvpunk Update',
                    })
                    vim.schedule(function() require('lazy').restore() end)
                else
                    vim.notify('Nvpunk update failed', vim.log.levels.ERROR, {
                        title = 'Nvpunk Update',
                    })
                end
            end,
        })
        :start()
end

M.nvpunk_clean = function()
    require('plenary.job')
        :new({
            command = '/usr/bin/rm',
            args = {
                '-rf',
                vim.fn.stdpath 'data',
            },
            on_exit = function(_, res)
                if res == 0 then
                    vim.notify(
                        'Removed Nvpunk data, restart to rebuild data',
                        vim.log.levels.INFO,
                        { title = 'Nvpunk Clear Data' }
                    )
                else
                    vim.notify(
                        'Failed to remove Nvpunk data',
                        vim.log.levels.ERROR,
                        {
                            title = 'Nvpunk Clear Data',
                        }
                    )
                end
            end,
        })
        :start()
end

local cmd = vim.api.nvim_create_user_command

cmd('NvpunkUpdate', function(_) M.nvpunk_update() end, { nargs = 0 })

cmd('NvpunkClearData', function(_) M.nvpunk_clean() end, { nargs = 0 })

cmd(
    'NvpunkHealthcheck',
    function(_) require 'nvpunk.internals.healthcheck'() end,
    { nargs = 0 }
)

cmd(
    'NvpunkExplorerToggle',
    function(_) vim.cmd 'Neotree toggle' end,
    { nargs = 0 }
)

cmd(
    'NvpunkExplorerOpen',
    function(_) vim.cmd 'Neotree reveal' end,
    { nargs = 0 }
)

cmd(
    'NvpunkExplorerClose',
    function(_) vim.cmd 'Neotree close' end,
    { nargs = 0 }
)

cmd('NvpunkNewFileDialog', function(_)
    vim.ui.input({
        prompt = 'New file path',
    }, function(txt)
        if txt == nil then return end
        txt = vim.trim(txt)
        if txt == '' then return end
        vim.cmd('e ' .. txt)
    end)
end, { nargs = 0 })

cmd('NvpunkReinstallJavaTools', function(_)
    local j = require 'nvpunk.lsp.jdtls_conf'
    j.remove_extra_java_tools(function() j.setup() end)
end, { nargs = 0 })

return M
