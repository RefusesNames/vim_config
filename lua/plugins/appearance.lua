return {
	{ 
		'diegoulloao/neofusion.nvim',
		priority = 1000 ,
		config = function()
			require('neofusion').setup{}
			vim.cmd([[ colorscheme neofusion ]])
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('lualine').setup{
				theme = require('neofusion.lualine')
			}
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
}
