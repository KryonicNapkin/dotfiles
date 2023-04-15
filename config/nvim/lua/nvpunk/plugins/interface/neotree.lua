-- file explorer
return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
        'MunifTanjim/nui.nvim',
        's1n7ax/nvim-window-picker',
    },
    lazy = true,
    config = function()
        require('window-picker').setup {
            autoselect_one = true,
            selection_chars = '1234567890-=QWERTYUIOPASDFGHJKLZXCVBNM',
            include_current = false,
            filter_rules = {
                bo = {
                    filetype = vim.tbl_filter(function(val)
                        return not vim.tbl_contains({
                            'alpha', 'dashboard', 'startify',
                            'help', 'vim'
                        }, val)
                    end, require 'nvpunk.internals.nonfile_buffers'),
                    buftype = { 'terminal', 'quickfix' },
                },
            },
            other_win_hl_color = '#9141ac',
            fg_color = '#f6f5f4',
        }

        vim.g.neo_tree_remove_legacy_commands = 1

        vim.fn.sign_define('DiagnosticSignError', {
            text = ' ',
            texthl = 'DiagnosticSignError',
        })
        vim.fn.sign_define('DiagnosticSignWarn', {
            text = ' ',
            texthl = 'DiagnosticSignWarn',
        })
        vim.fn.sign_define('DiagnosticSignInfo', {
            text = ' ',
            texthl = 'DiagnosticSignInfo',
        })
        vim.fn.sign_define('DiagnosticSignHint', {
            text = ' ',
            texthl = 'DiagnosticSignHint',
        })

        -- shim for non existing highlight groups
        local _hl_groups = {
            { new = 'NeoTreeIndentMarker', rep = 'WinSeparator' },
            { new = 'NeoTreeExpander', rep = 'NvimTreeFolderIcon' },
            -- { new = 'NeoTreeFileIcon', rep = '' } ,
            { new = 'NeoTreeModified', rep = 'NvimTreeGitDirty' },
            { new = 'NeoTreeFileName', rep = 'NvimTreeNormal' },
            { new = 'NeoTreeGitConflict', rep = 'NvimTreeGitDirty' },
            { new = 'NeoTreeGitUnstaged', rep = 'NvimTreeGitDirty' },
            { new = 'NeoTreeGitUntracked', rep = 'NvimTreeGitNew' },
            { new = 'NeoTreeGitRenamed', rep = 'NvimTreeGitRenamed' },
            { new = 'NeoTreeGitStaged', rep = 'NvimTreeGitStaged' },
            { new = 'NeoTreeWindowsHidden', rep = 'NvimTreeGitIgnored' },
            { new = 'NeoTreeDotfile', rep = 'NvimTreeGitIgnored' },
            { new = 'NeoTreeHiddenByName', rep = 'NvimTreeGitIgnored' },
            { new = 'NeoTreeGitIgnored', rep = 'NvimTreeGitIgnored' },
        }
        for _, v in ipairs(_hl_groups) do
            if vim.fn.hlexists(v.new) == 0 then
                vim.api.nvim_set_hl(0, v.new, { link = v.rep })
            end
        end

        require('neo-tree').setup {
            close_if_last_window = true,
            popup_border_style = require('nvpunk.preferences').get_small_window_border(),
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = true,
            sort_function = nil, -- can use custom
            use_default_mappings = false,
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
                indent = {
                    indent_size = 2,
                    padding = 1, -- padding left
                    with_markers = true, -- indent markers
                    indent_marker = '│',
                    last_indent_marker = '└',
                    highlight = 'NeoTreeIndentMarker',
                    with_expanders = true, -- expander arrows for folders
                    expander_collapsed = '',
                    expander_expanded = '',
                    expander_highlight = 'NeoTreeExpander',
                },
                icon = {
                    folder_closed = '',
                    folder_open = '',
                    folder_empty = '',
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = '*',
                    highlight = 'NeoTreeFileIcon',
                },
                modified = {
                    symbol = '',
                    highlight = 'NeoTreeModified',
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = 'NeoTreeFileName',
                },
                git_status = {
                    symbols = {
                        added = '',
                        modified = '',
                        unstaged = '',
                        conflict = '',
                        staged = '',
                        unmerged = '',
                        renamed = '',
                        deleted = '',
                        untracked = '',
                        ignored = '◌',
                    },
                },
            },
            window = {
                position = 'left',
                width = '30',
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    -- ['<leader>'] = {
                    --     'toggle_node', nowait = false  -- for leader key seqs
                    -- },
                    ['<2-LeftMouse>'] = 'open_with_window_picker',
                    ['<cr>'] = 'open_with_window_picker',
                    ['<esc>'] = 'revert_preview',
                    ['P'] = {
                        'toggle_preview',
                        config = { use_float = true },
                    },
                    ['i'] = 'split_with_window_picker',
                    ['s'] = 'vsplit_with_window_picker',
                    ['t'] = 'open_tabnew',
                    ['w'] = 'open_with_window_picker',
                    -- ['zo'] = 'expand_node',  -- no expand node command
                    ['zO'] = 'expand_all_nodes',
                    ['zc'] = 'close_node',
                    ['zC'] = 'close_all_nodes',
                    ['<leader>fn'] = 'add',
                    ['<leader>dn'] = 'add_directory',
                    ['<leader>rmrf'] = 'delete',
                    ['<F2>'] = 'rename',
                    ['<leader>fyy'] = 'copy_to_clipboard',
                    ['<leader>fdd'] = 'cut_to_clipboard',
                    ['<leader>fp'] = 'paste_from_clipboard',
                    ['r'] = 'refresh',
                    ['<F5>'] = 'refresh',
                    ['?'] = 'show_help',
                    -- ['['] = 'prev_source',
                    -- [']'] = 'next_source',
                },
            },
            filesystem = {
                filtered_items = {
                    visible = false, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_hidden = true, -- only works on Windows for hidden files/directories
                    hide_by_name = {
                        -- 'node_modules'
                    },
                    hide_by_pattern = { -- uses glob style patterns
                        -- '*.meta',
                        -- '*/src/*/tsconfig.json',
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                        -- '.gitignored',
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        -- '.DS_Store',
                        -- 'thumbs.db'
                    },
                    never_show_by_pattern = { -- uses glob style patterns
                        -- '.null-ls_*',
                    },
                },
                follow_current_file = true,
                group_empty_dirs = false,
                hijack_netrw_behavior = 'open_default',
                use_libuv_file_watcher = true,
                window = {
                    mappings = {
                        ['<leader>..'] = 'navigate_up',
                        ['<leader>cd'] = 'set_root',
                        ['<c-h>'] = 'toggle_hidden',
                        ['/'] = 'fuzzy_finder',
                        -- ['D'] = 'fuzzy_finder_directory',
                        -- ['f'] = 'filter_on_submit',
                        -- ['<c-x>'] = 'clear_filter',
                        ['<leader>g['] = 'prev_git_modified',
                        ['<leader>g]'] = 'next_git_modified',
                        ['<leader>ga'] = 'git_add_file',
                        ['<leader>gu'] = 'git_unstage_file',
                        ['<leader>xo'] = 'system_open',
                    },
                },
                commands = {
                    system_open = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        if vim.fn.has 'linux' == 1 then
                            vim.api.nvim_command(
                                string.format("silent !xdg-open '%s'", path)
                            )
                        elseif vim.fn.has 'macunix' == 1 then
                            vim.api.nvim_command(
                                string.format("silent !open '%s'", path)
                            )
                        else
                            vim.notify 'Operation unsupported'
                        end
                    end,
                },
            },
            buffers = {
                follow_current_file = true, -- This will find and focus the file in the active buffer every
                -- time the current file is changed while the tree is open.
                group_empty_dirs = false, -- when true, empty folders will be grouped together
                show_unloaded = true,
                window = {
                    mappings = {
                        -- ["bd"] = "buffer_delete",
                        -- ["<bs>"] = "navigate_up",
                        -- ["."] = "set_root",
                    },
                },
            },
            git_status = {
                window = {
                    position = 'float',
                    mappings = {
                        ['<leader>ga'] = 'git_add_file',
                        ['<leader>gu'] = 'git_unstage_file',
                    },
                },
            },
        }

        local km = require 'nvpunk.internals.keymapper'
        km.nkeymap('ge', '<cmd>Neotree toggle<CR>', 'פּ Toggle Explorer')
    end,
    keys = {
        {
            'ge',
            '<cmd>Neotree toggle<cr>',
            mode = 'n',
            desc = 'פּ Toggle Explorer',
        },
    },
    cmd = {
        'Neotree',
    },
}
