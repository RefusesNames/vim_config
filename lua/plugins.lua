-- TODO: find more general way to do this. Maybe '~/nvim/packages'
vim.o.runtimepath = vim.o.runtimepath ..',/home/jerome/.config/nvim/packages'
vim.o.packpath = vim.o.runtimepath

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
packer.startup(function()
	use { 'wbthomason/packer.nvim', opt=true }
	use { 'mizux/vim-colorschemes', opt=true, branch='main' }
	use { 'norcalli/nvim-colorizer.lua', as='colorizer', config=function() require('colorizer').setup() end }

	use { 'tpope/vim-commentary' }
	use { 'tpope/vim-fugitive' }

	-- TODO: maybe replace with lua equivalents:
	use {
		'junegunn/fzf.vim',
		requires = { {'junegunn/fzf'} }
	}

	use {
		'benwainwright/fzf-project',
		requires = {
			{'junegunn/fzf'},
			{'tpope/vim-fugitive'}
		}
	}

	use {	'liuchengxu/vim-which-key' }

	use { 'thiagoalessio/rainbow_levels.vim', as='rainbow_levels' }

end)

return packer
