return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = true,
		ft = { 'cpp', 'cs', 'markdown', 'xml', 'lua' },
		-- run = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup{
				ensure_installed = { 'cpp', 'lua', 'c_sharp', 'markdown' },
				highlight = { enable = true },
				incremental_selection = { enable = true },
				textobjects = { enable = true },
				rainbow = {
					enable = true,
					extended_mode = true
				}
			}
		end,
	},
	"hiphish/rainbow-delimiters.nvim",
}
