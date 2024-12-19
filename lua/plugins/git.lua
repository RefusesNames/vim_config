return {
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
	}
}
