local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "single" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use "windwp/nvim-autopairs" -- Auropairs, integrates with both cmp and treesitter
    use "RRethy/vim-illuminate" -- higlights the word under the cursor
    use "nvim-tree/nvim-web-devicons"

    -- Multi cursor
    use "mg979/vim-visual-multi"

    use "ziglang/zig.vim" -- zig syntax highlighting

    -- Lualine
    use "nvim-lualine/lualine.nvim" -- Status line for neovim
    -- Neotree
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    }
    -- Syntax highlighting for wired configuration file
    use "ron-rs/ron.vim"
    -- Go programming language tools
    use "fatih/vim-go"
    -- Cmp
    --use "neoclide/coc.nvim" -- completion
    use "hrsh7th/nvim-cmp"      -- Completion plugin
    use "hrsh7th/cmp-buffer"      -- Buffer Completion
    use "hrsh7th/cmp-path"      -- Path completion
    use "hrsh7th/cmp-cmdline"      -- Command line completion
    use "saadparwaiz1/cmp_luasnip" -- snippet completion
    use "hrsh7th/cmp-nvim-lsp"      -- Completion for Lsp
    use "hrsh7th/vim-vsnip"      -- Completion for Lsp
    use "hrsh7th/cmp-nvim-lua"      -- Completion for Lua

    -- My snippets
    use "L3MON4D3/LuaSnip"       -- snippet engine
    use "rafamadriz/friendly-snippets"  -- Snippet engine

    -- Colorscheme
    use "navarasu/onedark.nvim" -- Onedark Colorscheme

    -- Colorizer
    use "norcalli/nvim-colorizer.lua" -- Nvim colorizer

    -- Lsp
    use "neovim/nvim-lspconfig" -- enable Lsp
    use "williamboman/mason.nvim" -- Nvim lsp installer
    use "williamboman/mason-lspconfig.nvim" -- Nvim lsp installer
    use "ray-x/lsp_signature.nvim" -- function signatures

    -- Git 
    use "lewis6991/gitsigns.nvim" -- git integration
    use "tpope/vim-fugitive" -- git integration

    -- Better diagnostics
    use "sontungexpt/better-diagnostic-virtual-text"

    -- Telescope
    use "nvim-telescope/telescope.nvim" -- telescope

    -- Arduino
    use "https://github.com/stevearc/vim-arduino"

    -- Rust
    use "mrcjkb/rustaceanvim" -- rust tools

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    -- TODO comments
    use {
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    }
    -- Dashboard
    use {
        "nvimdev/dashboard-nvim",
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
              -- config 
                theme = 'hyper', --  theme is doom and hyper default is hyper
                disable_move = false,   --  default is false disable move keymap for hyper
                shortcut_type = 'number',  --  shorcut type 'letter' or 'number'
                shuffle_letter = true,--  default is true, shortcut 'letter' will be randomize, set to false to have ordered letter.
                change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
                config = {},    --  config used for theme
                hide = {
                  statusline,    -- hide statusline default is true
                  tabline,       -- hide the tabline
                  winbar,        -- hide winbar
                },
                preview = {
                  command,       -- preview command
                  file_path,     -- preview file path
                  file_height,   -- preview file height
                  file_width,    -- preview file width
                },
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }
    -- Commenuse 
    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("toggleterm").setup()
        end
    }
    use {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup()
        end
    }
    use {
        "akinsho/bufferline.nvim",
        tag = "*",
        requires = {
            "nvim-tree/nvim-web-devicons"
        }
    }

    use {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
