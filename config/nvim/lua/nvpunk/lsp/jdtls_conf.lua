local M = {}

--- Send notification with jdtls context
---@param msg string
---@param type? number from vim.log.levels
local function this_notif(msg, type)
    if type == nil then type = vim.log.levels.INFO end
    vim.notify(msg, type, { title = 'nvpunk.lsp.jdtls' })
end

local function this_err(msg) this_notif(msg, vim.log.levels.ERROR) end

local jdtls = require 'jdtls'
local jdtls_setup = require 'jdtls.setup'
local jdtls_dap = require 'jdtls.dap'

local data_dir = vim.fn.stdpath 'data'
local jdtls_install = data_dir .. '/mason/packages/jdtls'

local vscode_java_test_path = data_dir .. '/vscode-java-test'
local java_debug_path = data_dir .. '/java-debug'

-- replace with a specific java version (newer is better)
local java_home = ''
local java_exec = 'java'

local Job = require 'plenary.job'

M.has_java_debug = function() return vim.fn.isdirectory(java_debug_path) ~= 0 end

M.has_vscode_java_test = function()
    return vim.fn.isdirectory(vscode_java_test_path) ~= 0
end

M.install_java_debug = function()
    this_notif 'Installing java-debug'

    local function install()
        Job:new({
            command = java_debug_path .. '/mvnw',
            args = { 'clean', 'install' },
            cwd = java_debug_path,
            env = { ['JAVA_HOME'] = java_home },
            on_exit = function(_, ret)
                if ret == 0 then
                    this_notif 'java-debug installed'
                    vim.schedule(function() M.setup() end)
                else
                    this_err 'Failed to install java-debug'
                end
            end,
        }):start()
    end

    local function clone()
        Job:new({
            command = 'git',
            args = {
                'clone',
                'https://github.com/microsoft/java-debug',
                java_debug_path,
            },
            on_exit = function(_, ret)
                if ret == 0 then
                    install()
                else
                    this_err 'Failed to clone java-debug'
                end
            end,
        }):start()
    end

    clone()
end

M.install_vscode_java_test = function()
    this_notif 'Installing vscode-java-test'

    local function build_plugin()
        Job:new({
            command = 'npm',
            args = { 'run', 'build-plugin' },
            cwd = vscode_java_test_path,
            env = { ['JAVA_HOME'] = java_home },
            on_exit = function(_, ret2)
                if ret2 == 0 then
                    this_notif 'vscode-java-test installed'
                    vim.schedule(function() M.setup() end)
                else
                    this_err 'Failed to build vscode-java-test'
                end
            end,
        }):start()
    end

    local function npm_install()
        Job:new({
            command = 'npm',
            args = { 'install' },
            cwd = vscode_java_test_path,
            env = { ['JAVA_HOME'] = java_home },
            on_exit = function(_, ret1)
                if ret1 == 0 then
                    build_plugin()
                else
                    this_err 'Failed to get deps for vscode-java-test'
                end
            end,
        }):start()
    end

    local function clone()
        Job:new({
            command = 'git',
            args = {
                'clone',
                'https://github.com/microsoft/vscode-java-test',
                vscode_java_test_path,
            },
            on_exit = function(_, ret)
                if ret == 0 then
                    npm_install()
                else
                    this_err 'Failed to clone vscode-java-test'
                end
            end,
        }):start()
    end

    clone()
end

--- Remove vscode java test and java debug
---@param cb function
M.remove_extra_java_tools = function(cb)
    Job:new({
        command = 'rm',
        args = { '-rf', vscode_java_test_path, java_debug_path },
        on_exit = function(_, _) vim.schedule(cb) end,
    }):start()
end

M.start_jdtls = function()
    -- local bundles = {
    --     vim.fn.glob(
    --         java_debug_path
    --             .. '/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'
    --     ),
    -- }
    -- vim.list_extend(
    --     bundles,
    --     vim.split(vim.fn.glob(vscode_java_test_path .. '/server/*.jar'), '\n')
    -- )
    local bundles = {}  -- plain disable vscode-java-test and java-debug as they're broken

    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local workspace = vim.fn.stdpath 'data' .. '/nvpunk_jdtls_workspace'

    -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
    local config = {
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {

            java_exec, -- or '/path/to/java11_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-javaagent:' .. jdtls_install .. '/lombok.jar',
            '-Xms1g',
            '-Xmx2G',

            '-jar',
            vim.fn.glob(
                jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar'
            ),

            '-configuration',
            jdtls_install .. '/config_linux',
            '-data',
            workspace,

            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',

            -- See `data directory configuration` section in the README
        },

        -- 💀
        -- This is the default if not provided, you can remove it. Or adjust as needed.
        -- One dedicated LSP server & client will be started per unique root_dir
        root_dir = jdtls_setup.find_root { 'pom.xml', '.git', 'mvnw', 'gradlew' },

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
            java = {
                eclipse = { downloadSources = true },
                maven = { downloadSources = true },
                configuration = { updateBuildConfiguration = 'interactive' },
                implementationCodeLens = { enabled = true },
                referencesCodeLens = { enabled = true },
                references = { includeDecompiledSources = true },
                inlayHints = { parameterNames = { enabled = true } },
                format = { enabled = false },
            },
            signatureHelp = { enabled = true },
            extendedClientCapabilities = extendedClientCapabilities,
        },

        -- Language server `initializationOptions`
        -- You need to extend the `bundles` with paths to jar files
        -- if you want to use additional eclipse.jdt.ls plugins.
        --
        -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
        flags = { allow_incremental_sync = true },
        init_options = {
            bundles = bundles,
        },

        on_attach = function(client, bufnr)
            -- local function extra_keymaps(bm)
            --     bm.nkeymap(
            --         '<leader>bjr',
            --         '<cmd>JdtRefreshDebugConfigs<cr>',
            --         'Refresh Java Debugger Conf'
            --     )
            --     bm.nkeymap(
            --         '<leader>bjc',
            --         '<cmd>lua require"jdtls".test_class()<cr>',
            --         'Test Class'
            --     )
            --     bm.nkeymap(
            --         '<leader>bjn',
            --         '<cmd>lua require"jdtls".test_nearest_method()<cr>',
            --         'Test Nearest Method'
            --     )
            -- end
            -- require('nvpunk.lsp.keymaps').set_lsp_keymaps(
            --     client,
            --     bufnr,
            --     extra_keymaps
            -- )
            -- jdtls_dap.setup_dap_main_class_configs()
            -- jdtls.setup_dap { hotcodereplace = 'auto' }
        end,
        capabilities = require('nvpunk.lsp.capabilities').capabilities,
    }

    -- This starts a new client & server,
    -- or attaches to an existing client & server depending on the `root_dir`.
    jdtls.start_or_attach(config)
end

M.setup = function()
    require 'nvpunk.internals.find_jdtls_java'(function(home)
        java_exec = (home .. '/bin/java') or java_exec
        java_home = home
        -- if not M.has_java_debug() then return M.install_java_debug() end
        -- if not M.has_vscode_java_test() then
        --     return M.install_vscode_java_test()
        -- end
        M.start_jdtls()
    end)
end

return M
