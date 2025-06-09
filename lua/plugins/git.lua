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
		config = function()
			require('neogit').setup{
				kind = 'split'
			}

			vim.keymap.set('n', '<leader>gg', function()
				require('neogit').open({ kind = 'floating' })
			end)
		end
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}
}
