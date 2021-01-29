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
	use { 'neovim/nvim-lspconfig', config=function() configureLanguageServer() end }
	use { 'nvim-lua/completion-nvim' }

	use { 'tpope/vim-commentary' }
	use { 'tpope/vim-fugitive' }

	-- use { 'nvim-treesitter/nvim-treesitter', config=function() vim.cmd('TSUpdate') end }
	use { 'nvim-treesitter/nvim-treesitter' }
	
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
	local lsp = require('lspconfig')

	-- lua
	-- compile from here: https://github.com/sumneko/lua-language-server
	-- lsp.sumneko_lua.setup{
	-- 	cmd={ 'D:\\bin\\lua-language-server\\lua-language-server.exe' }
	-- }

	-- typescript
	-- npm install -g typescript-language-server
	lsp.tsserver.setup{on_attach=require('completion').on_attach}
	-- npm install -g diagnostic-languageserver
	lsp.diagnosticls.setup{
		filetypes = {"javascript", "typescript"},
		root_dir = function(fname)
			return lsp.util.root_pattern("tsconfig.json")(fname) or
				lsp.util.root_pattern(".eslintrc.js")(fname);
		end,
		init_options = {
			linters = {
				eslint = {
					command = "./node_modules/.bin/eslint",
					rootPatterns = {".eslintrc.js", ".git"},
					debounce = 100,
					args = {
						"--stdin",
						"--stdin-filename",
						"%filepath",
						"--format",
						"json"
					},
					sourceName = "eslint",
					parseJson = {
						errorsRoot = "[0].messages",
						line = "line",
						column = "column",
						endLine = "endLine",
						endColumn = "endColumn",
						message = "[eslint] ${message} [${ruleId}]",
						security = "severity"
					},
					securities = {
						[2] = "error",
						[1] = "warning"
					}
				},
			},
			filetypes = {
				javascript = "eslint",
				typescript = "eslint"
			}
		}
	}
end

return packer
