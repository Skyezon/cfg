local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        --find stuff
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim'
                ,
                build = "make"
            }
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    {
        -- lsp package manager
        "williamboman/mason.nvim",
        build = ":MasonUpdate"           -- :MasonUpdate updates registry contents
    },
    "williamboman/mason-lspconfig.nvim", -- bridge mason with lsp
    "neovim/nvim-lspconfig",             -- base lsp config
    "folke/tokyonight.nvim",             -- colorscheme	

    -- nvim cmp stuff
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'SirVer/ultisnips',

    'tpope/vim-fugitive',        -- git related stuff
    'tpope/vim-surround',        -- for creating brackets auto

    'windwp/nvim-autopairs',     -- autopair brackets like in vscode
    'nvim-lualine/lualine.nvim', -- better looking status line
    'linrongbin16/lsp-progress.nvim',
    {
        'nvimdev/lspsaga.nvim', -- better looking lsp stuff
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'nvim-treesitter/nvim-treesitter'
        }

    },
    'numToStr/Comment.nvim',    -- easier commenting anything
    'mbbill/undotree',          -- better undo stuff
    'windwp/nvim-ts-autotag',
    'MagicDuck/grug-far.nvim',   -- find and replace workspace
    'ray-x/lsp_signature.nvim', -- shows function param when typing
    'lewis6991/gitsigns.nvim',  -- signs in column and blame
    {
        "mikavilpas/yazi.nvim",
        events = "VeryLazy"
    }, -- file directory
}

require("lazy").setup(plugins)
