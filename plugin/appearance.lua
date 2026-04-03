vim.pack.add({
	'https://github.com/ribru17/bamboo.nvim',
	'https://github.com/nvim-lualine/lualine.nvim',
	'https://github.com/lukas-reineke/indent-blankline.nvim',
	'https://github.com/MeanderingProgrammer/render-markdown.nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/hiphish/rainbow-delimiters.nvim',
	'https://github.com/nvim-tree/nvim-web-devicons',
})

require('bamboo').setup{}
require('bamboo').load()

require('lualine').setup{}

-- TODO: do we need this?
-- 	{
-- 		"lukas-reineke/indent-blankline.nvim",
-- 		main = "ibl",
-- 		opts = {}
-- 	},
