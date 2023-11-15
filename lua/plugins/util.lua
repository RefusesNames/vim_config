return {
	'rmehri01/onenord.nvim',
	-- 'tpope/vim-fugitive',
	'gpanders/editorconfig.nvim',
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local telescope = require('telescope')
			telescope.setup {
				defaults = {
					file_ignore_patterns = { ".git", ".svn" }
				}
			}
			-- telescope.load_extension('yabs')
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('lualine').setup{}
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		-- run = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup{
				ensure_installed = { 'cpp', 'lua', 'c_sharp' },
				highlight = { enable = true },
				incremental_selection = { enable = true },
				textobjects = { enable = true },
				rainbow = {
					enable = true,
					extended_mode = true
				}
			}
		end,
		dependencies = {
			{ 'p00f/nvim-ts-rainbow' }
		}

	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim",        -- optional
			"ibhagwan/fzf-lua",              -- optional
		},
		config = function()
			require('neogit').setup{
				kind = 'split'
			}
		end
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},

	-- LSP and Completion
	'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
	'hrsh7th/nvim-cmp', -- Autocompletion plugin
	'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
	'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
	'L3MON4D3/LuaSnip' -- Snippets plugin

	-- NO IDEA IF I STILL WANT THIS
	-- {
	-- 	'pianocomposer321/yabs.nvim',
	-- 	dependencies = { 'nvim-lua/plenary.nvim' },
	-- 	opts = {
	-- 		output_types = {
	-- 			quickfix = {
	-- 				open_on_run = 'always',
	-- 			},
	-- 		},
	-- 	}
	-- 	-- config = function()
	-- 	-- 	require('yabs'):setup({
	-- 	-- 		opts = {
	-- 	-- 			output_types = {
	-- 	-- 				quickfix = {
	-- 	-- 					open_on_run = 'always',
	-- 	-- 				},
	-- 	-- 			},
	-- 	-- 		},
	-- 	-- 	})
	-- 	-- end
	-- },
}
