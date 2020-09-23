-- TODO: find more general way to do this. Maybe '~/nvim/packages'
vim.o.runtimepath = vim.o.runtimepath ..',C:\\Users\\jerom\\AppData\\Local\\nvim\\packages'
vim.o.packpath = vim.o.runtimepath

vim.cmd [[packadd packer.nvim]]

vim._update_package_paths()

local packer = require('packer')
packer.startup(function()
	use { 'wbthomason/packer.nvim', opt=true }
	use { 'mizux/vim-colorschemes', opt=true }
	use { 'norcalli/nvim-colorizer.lua', as='colorizer', config=function() require('colorizer').setup() end }
	use { 'neovim/nvim-lspconfig', config=configureLanguageServer }
	use { 'nvim-lua/completion-nvim' }
	
	-- TODO: maybe replace with lua equivalents:
	use {
		'junegunn/fzf.vim',
		requires = { {'junegunn/fzf'} }
	}

end)

function configureLanguageServer()
	local lsp = require('nvim_lsp')

	-- lua
	-- compile from here: https://github.com/sumneko/lua-language-server
	lsp.sumneko_lua.setup{
		cmd={ 'D:\\bin\\lua-language-server\\lua-language-server.exe' }
	}

	-- typescript
	-- npm install -g typescript-language-server
	lsp.tsserver.setup{on_attach=require('completion').on_attach}

	-- html
	-- npm install -g vscode-html-languageserver-bin
	lsp.html.setup{on_attach=require('completion').on_attach}
end

return packer
