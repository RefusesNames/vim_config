return {
	'gpanders/editorconfig.nvim',
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},

	-- LSP and Completion
	'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
	'hrsh7th/nvim-cmp', -- Autocompletion plugin
	'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
	'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
	'L3MON4D3/LuaSnip', -- Snippets plugin


	-- debugging
	'mfussenegger/nvim-dap',
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-neotest/nvim-nio'
		}
	}

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
