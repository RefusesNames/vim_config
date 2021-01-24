-- TODO: find more general way to do this. Maybe '~/nvim/packages'
vim.o.runtimepath = vim.o.runtimepath ..',/home/jerome/.config/nvim/packages'
vim.o.packpath = vim.o.runtimepath

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
packer.startup(function()
	use { 'wbthomason/packer.nvim', opt=true }
	use { 'mizux/vim-colorschemes', opt=true, branch='main' }
	use { 'norcalli/nvim-colorizer.lua', as='colorizer', config=function() require('colorizer').setup() end }
	-- use { 'neovim/nvim-lspconfig', config=configureLanguageServer }
	use { 'neovim/nvim-lspconfig', config=configureLanguageServer }
	use { 'nvim-lua/completion-nvim' }

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

function configureLanguageServer()
	local lsp = require('nvim_lsp')

	-- lua
	-- compile from here: https://github.com/sumneko/lua-language-server
	lsp.sumneko_lua.setup{
		cmd={ 'D:\\bin\\lua-language-server\\lua-language-server.exe' }
	}

	-- c#
	-- compile from here: https://github.com/omnisharp/omnisharp-roslyn
	lsp.omnisharp.setup{
		cmd = { "C:\\bin\\omnisharp\\omnisharp.exe", "--languageserver", "--hostPID", "2801" }
	}

	-- typescript
	-- npm install -g typescript-language-server
	lsp.tsserver.setup{on_attach=require('completion').on_attach}

	-- html
	-- npm install -g vscode-html-languageserver-bin
	lsp.html.setup{on_attach=require('completion').on_attach}

	-- php
	-- npm install -g intelephense
	lsp.intelephense.setup{on_attach=require('completion').on_attach}

	-- cmake
	-- pip install cmake-language-server
	lsp.cmake.setup{}
end

return packer
