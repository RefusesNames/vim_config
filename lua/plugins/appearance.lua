return {
	{
		'ribru17/bamboo.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('bamboo').setup{}
			require('bamboo').load()
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'kyazdani42/nvim-web-devicons' },
		lazy = false,
		config = function()
			require('lualine').setup{}
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		lazy = true,
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		ft = 'markdown',
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	}
}
