
-- Bootstrap Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ General settings ]]
--
-- Map leader keys before any plugin is required
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Indentation related settings
vim.o.breakindent = true
vim.o.autoindent = true
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.tabstop = 4

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Copy and paste from clipboard
vim.keymap.set({'v', 'n', 'o'}, '<leader>y', '"+y', { remap = true, silent = true, desc = 'Yank selection to clipboard' })
vim.keymap.set({'v', 'n', 'o'}, '<leader>Y', '"+yg_', { remap = true, silent = true, desc = 'Yank to end of line to clipboard' })
vim.keymap.set({'v', 'n', 'o'}, '<leader>p', '"+p', { remap = true, silent = true, desc = 'Paste from clipboard' })
vim.keymap.set({'v', 'n', 'o'}, '<leader>P', '"+P', { remap = true, silent = true, desc = 'Backward paste from clipboard' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

require('lazy').setup({
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			{
				'neovim/nvim-lspconfig',
				event = { 'BufReadPre', 'BufNewFile' },
				init = function()
					-- Diagnostic keymaps
					vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
					vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
					vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
					vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Show diagnostic list' })

					-- LSP settings.
					--  This function gets run when an LSP connects to a particular buffer.
					local on_attach = function(_, bufnr)
					  -- NOTE: Remember that lua is a real programming language, and as such it is possible
					  -- to define small helper and utility functions so you don't have to repeat yourself
					  -- many times.
					  --
					  -- In this case, we create a function that lets us more easily define mappings specific
					  -- for LSP related items. It sets the mode, buffer and description for us each time.
					  local nmap = function(keys, func, desc)
					    if desc then
					      desc = 'LSP: ' .. desc
					    end

					    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
					  end

					  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
					  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

					  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
					  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
					  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
					  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
					  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
					  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

					  -- See `:help K` for why this keymap
					  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
					  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

					  -- Lesser used LSP functionality
					  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
					  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
					  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
					  nmap('<leader>wl', function()
					    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					  end, '[W]orkspace [L]ist Folders')

					  -- Create a command `:Format` local to the LSP buffer
					  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
					    vim.lsp.buf.format()
					  end, { desc = 'Format current buffer with LSP' })
					end

					-- Enable the following language servers
					--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
					--
					--  Add any additional override configuration in the following tables. They will be passed to
					--  the `settings` field of the server config. You must look up that documentation yourself.
					local servers = {
					  clangd = { },
					  -- gopls = {},
					  -- pyright = {},
					  -- rust_analyzer = {},
					  -- tsserver = {},

					  -- sumneko_lua = {
					    -- Lua = {
					    --   workspace = { checkThirdParty = false },
					    --   telemetry = { enable = false },
					    -- },
					  -- },
					}

					-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

					-- Setup Mason so it can handle external tooling
					local mason_lspconfig = require('mason-lspconfig')
					mason_lspconfig.setup {
						ensure_installed = vim.tbl_keys(servers)
					}

					mason_lspconfig.setup_handlers {
					  function(server_name)
					    require('lspconfig')[server_name].setup {
					      capabilities = capabilities,
					      on_attach = on_attach,
					      settings = servers[server_name],
					    }
					  end,
					}
				end,
			},
			{
				-- Automatically install LSPs to stdpath for neovim
				'williamboman/mason.nvim',
				lazy = false,
				build = ':MasonUpdate',
				config = true
			},

			{
				'williamboman/mason-lspconfig.nvim',
				lazy = false
			},

			{
				-- Useful status updates for LSP
				'folke/noice.nvim',
				config = true,
				dependencies = {
					-- UI Components
					'MunifTanjim/nui.nvim',
					-- Notification view
					'rcarriga/nvim-notify'
				},
			},

			-- Additional lua configuration, makes nvim stuff amazing
			'folke/neodev.nvim',

			{
				-- Completion engine
				'hrsh7th/nvim-cmp',
				dependencies = {
					'hrsh7th/cmp-nvim-lsp',
					'L3MON4D3/LuaSnip',
					'saadparwaiz1/cmp_luasnip'
				},
				config = function() 
					local cmp = require('cmp')
					cmp.setup({
						snippet = {
							expand = function(args)
								-- Snippet engine to be used
								require('luasnip').lsp_expand(args.body)
							end,
						},
						mapping = cmp.mapping.preset.insert({
							['<Tab>'] = cmp.mapping.confirm {
								behavior = cmp.ConfirmBehavior.Replace,
								select = true,
							},
							-- Move up and down suggestions
							['<A-j>'] = cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.select_next_item()
								elseif luasnip.expand_or_jumpable() then
									luasnip.expand_or_jump()
								else
									fallback()
								end
							end, { 'i', 's' }),
							['<A-k>'] = cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.select_prev_item()
								elseif luasnip.jumpable(-1) then
									luasnip.jump(-1)
								else
									fallback()
								end
							end, { 'i', 's' }),
						}),
						sources = {
							{ name = 'nvim_lsp' },
							{ name = 'luasnip' },
							{ name = 'lua-latex-symbols', option = { cache = true }},
							{ name = 'nvim_lua' },
						},
					})
				end
			},
		}
	},

	{
		-- Keymaps Helper
		'folke/which-key.nvim',
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 400
		end,
		opts = {
			spelling = { enabled = false }
		}
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
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		init = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
		config = function()
			-- [[ Configure Treesitter ]]
			-- See `:help nvim-treesitter`
			require('nvim-treesitter.configs').setup {
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					'c', 'cpp', 'elixir', 'lua', 'rust', 'regex', 'typescript', 'vimdoc', 'vim'
				},
				highlight = { enable = true },
				indent = { enable = true, disable = { 'python' } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<c-space>',
						node_incremental = '<c-space>',
						scope_incremental = '<c-s>',
						node_decremental = '<c-backspace>',
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							['aa'] = '@parameter.outer',
							['ia'] = '@parameter.inner',
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['ac'] = '@class.outer',
							['ic'] = '@class.inner',
						},
					},
					swap = {
						enable = true,
						swap_next = {
							['<leader>a'] = '@parameter.inner',
						},
						swap_previous = {
							['<leader>A'] = '@parameter.inner',
						},
					},
				},
			}
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
		event = 'VeryLazy',
		opts = {
			-- Gitsigns
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
				vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
				vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
			end,
		},
	},

	{
		-- Fancier statusline
		'nvim-lualine/lualine.nvim',
		config = true
	},

	{
		-- Add indendation guides to blank lines
		'lukas-reineke/indent-blankline.nvim',
		opts = {
			-- See `:help indent_blankline.txt`
			char_list = { '|', '¦', '┆', '┊' },
			show_trailing_blankline_indent = false,
			use_treesitter = true,
			show_current_context = true,
		},
	},

	{
		-- Comment visual regions/lines
		'numToStr/Comment.nvim',
		event = 'VeryLazy',
		config = true
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
		version = false,
		config = true
	},

	{
		-- Better handling of pairs of symbols
		'echasnovski/mini.pairs',
		version = false,
		config = true
	},
	  
	{
		-- Split and join arguments
		'echasnovski/mini.splitjoin',
		version = false,
		config = true
	},

	{
		-- Surround actions
		'echasnovski/mini.surround',
		event = 'VeryLazy',
		version = false,
		config = true
	},

	{
		-- Fuzzy Finder (files, LSP, etc...)
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			-- See `:help telescope` and `:help telescope.setup()`
			local actions = require('telescope.actions')
			require('telescope').setup {
				defaults = {
					mappings = {
						i = {
							['<C-u>'] = false,
							['<C-d>'] = false,
							['<A-j>'] = actions.move_selection_next,
							['<A-k>'] = actions.move_selection_previous,
						}
					}
				},
				pickers = {
					buffers = {
						mappings = {
							i = {
								['<A-d>'] = actions.delete_buffer + actions.move_to_top,
							}
						}
					},
					find_files = {
						mappings = {
							n = {
								['cd'] = function(prompt_buffer)
									local selection = require('telescope.actions.state').get_selected_entry()
									local dir = vim.fn.fnamemodify(selection.path, ':p:h')
									actions.close(prompt_buffer)
									vim.cmd(string.format("silent lcd %s", dir))
								end
							}
						}
					}
				}
			}
		end,
		init = function()
			-- See `:help telescope.builtin`
			vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
			vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
			vim.keymap.set('n', '<leader>/', function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end, { desc = '[/] Fuzzily search in current buffer]' })

			vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
			vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
			vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
			vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
			vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
		end,
	},

	{
		-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
		'nvim-telescope/telescope-fzf-native.nvim',
		cond = vim.fn.executable 'make' == 1,
		build = 'make',
		config = function()
			require('telescope').load_extension('fzf')
		end,
	},

	{
		-- Filetype and Syntax plugin for LaTeX
		'lervag/vimtex',
		init = function()
			vim.g.vimtex_view_method = 'zathura'
			vim.g.vimtex_quickfix_ignore_filters = {
				'Underfull \\hbox',
				'Overfull \\hbox',
				'Package hyperref Warning: Token not allowed in a PDF string',
			}
		end,
	},

	{
		-- Autocomplete and insertion of LaTeX Symbols
		'amarakon/nvim-cmp-lua-latex-symbols',
	},

	{
		-- Enables using multiple cursors
		'mg979/vim-visual-multi',
		event = 'VeryLazy',
		branch = 'master'
	},
})
