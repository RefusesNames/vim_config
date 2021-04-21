-- TODO: find more general way to do this. Maybe '~/nvim/packages'
vim.o.runtimepath = vim.o.runtimepath ..',/home/jerome/.config/nvim/packages'
vim.o.packpath = vim.o.runtimepath

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
packer.startup(function()
	use { 'wbthomason/packer.nvim', opt=true }
	use { 'norcalli/nvim-colorizer.lua', as='colorizer', config=function() require('colorizer').setup() end }

	use { 'tpope/vim-commentary' }
	use { 'tpope/vim-fugitive' }

	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	use {
		'neoclide/coc.nvim',
		branch = 'release'
	}

	use { 'folke/tokyonight.nvim' }

	use { 'kdav5758/TrueZen.nvim' }

	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}

	use {	'liuchengxu/vim-which-key' }

	use { 'thiagoalessio/rainbow_levels.vim', as='rainbow_levels' }

end)

return packer
