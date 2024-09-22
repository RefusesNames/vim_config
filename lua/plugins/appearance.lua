return {
	-- { 
	-- 	'diegoulloao/neofusion.nvim',
	-- 	priority = 1000 ,
	-- 	config = function()
	-- 		require('neofusion').setup{}
	-- 		vim.cmd([[ colorscheme neofusion ]])
	-- 	end
	-- },
	{
		'eldritch-theme/eldritch.nvim',
		priority = 1000,
		lazy = false,
		config = function()
			vim.cmd([[ colorscheme eldritch ]])
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			require('lualine').setup{
				-- theme = require('neofusion.lualine')
			}
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
}
