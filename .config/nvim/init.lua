
-- Bootstrap Lazy
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

-- Map leader keys before any plugin is required
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('lazy').setup({
  {
	'neovim/nvim-lspconfig',
	dependencies = {
		{
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			lazy = false,
			build = ':MasonUpdate'
		},
		{
			'williamboman/mason-lspconfig.nvim',
			lazy = false
		},

		{
			-- Useful status updates for LSP
			'folke/noice.nvim',
			dependencies = {
				-- UI Components
				'MunifTanjim/nui.nvim',
				-- Notification view
				'rcarriga/nvim-notify'
			}
		},

		-- Additional lua configuration, makes nvim stuff amazing
		'folke/neodev.nvim',
	},
  },

  {
	-- Keymaps Helper
	'folke/which-key.nvim',
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 400
		require('which-key').setup()
	end
  },

  {
	'AlexvZyl/nordic.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require 'nordic'.load()
	end
  },

  {
	-- Completion engine
	'hrsh7th/nvim-cmp',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip'
	}
  },

  {
	-- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	init = function()
		pcall(require('nvim-treesitter.install').update { with_sync = true })
	end
  },

  {
	-- Additional text objects via treesitter
	'nvim-treesitter/nvim-treesitter-textobjects',
  },

  {
	  -- Git wrapper for Vim
	  'tpope/vim-fugitive',
  },

  {
	  -- Git wrapper for Vim
	  'lewis6991/gitsigns.nvim',
  },

  {
	  -- Fancier statusline
	  'nvim-lualine/lualine.nvim',
  },

  {
	  -- Add indendation guides to blank lines
	  'nvim-lualine/lualine.nvim',
  },

  {
	  -- Comment visual regions/lines
	  'numToStr/Comment.nvim',
  },

  {
	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth' 
  },

  {
	-- Only show relative line number when focused
	'sitiom/nvim-numbertoggle',
  },

  {
	-- Move any selection in any direction
	'echasnovski/mini.move',
	version = false
  },

  {
	-- Better handling of pairs of symbols
	'echasnovski/mini.pairs',
	version = false
  },
  
  {
	-- Split and join arguments
	'echasnovski/mini.splitjoin',
	version = false
  },

  {
	-- Surround actions
	'echasnovski/mini.surround',
	version = false
  },

  {
	-- Fuzzy Finder (files, LSP, etc...)
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' }
	
  },

  {
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	'nvim-telescope/telescope-fzf-native.nvim',
	cond = vim.fn.executable 'make' == 1,
	build = 'make',
  },

  {
	-- Filetype and Syntax plugin for LaTeX
	'lervag/vimtex'
  },

  {
	-- Autocomplete and insertion of LaTeX Symbols
	'kdheepak/cmp-latex-symbols',
  },

  {
	-- Enables using multiple cursors
	'mg979/vim-visual-multi',
	branch = 'master'
  },
})
