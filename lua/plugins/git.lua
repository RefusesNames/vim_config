return {
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim",        -- optional
			"ibhagwan/fzf-lua",              -- optional
		},
		cmd = 'Neogit',
		keys = {
			{ '<leader>gg', function()
				require('neogit').open({ kind = 'floating' })
			end,
			desc = 'Open NeoGit in float'}
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
