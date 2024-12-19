return {
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

	}
}
