-- TODO: find more general way to do this. Maybe '~/nvim/packages'
vim.o.runtimepath = vim.o.runtimepath ..',~\\AppData\\Local\\nvim\\packages'
vim.o.packpath = vim.o.runtimepath

vim.cmd [[packadd packer.nvim]]

vim._update_package_paths()

local packer = require('packer')
packer.startup(function()
	use { 'wbthomason/packer.nvim', opt=true }
	use { 'mizux/vim-colorschemes', opt=true }
	use { 'norcalli/nvim-colorizer.lua', as='colorizer', config=function() require('colorizer').setup() end }
	use { 'neovim/nvim-lspconfig', config=configureLanguageServer }
	
	-- TODO: maybe replace with lua equivalents:
	use {
		'junegunn/fzf.vim',
		requires = { {'junegunn/fzf'} }
	}
end)

function configureLanguageServer()
	local lsp = require('nvim_lsp')
	-- lua
	lsp.sumneko_lua.setup{
		cmd={ 'D:\\bin\\lua-language-server\\lua-language-server.exe' }
	}
	-- typescript
	lsp.tsserver.setup{}
end

return packer
