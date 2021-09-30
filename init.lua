-- this part is just copied from my old vimrc,
-- better replace it with the proper lua commands
vim.api.nvim_exec(
[[
let mapleader = "\<Space>"

if has("win64") || has("win32")
	" see ':h shell-powershell' and
	" https://github.com/junegunn/vim-plug/issues/895#issuecomment-544130552
	let &shell = has('win64') ? 'pwsh.exe -NoLogo': 'powershell.exe'
	set shellquote= shellpipe=\| shellxquote=
	set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
	set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif
]],
true)

vim.api.nvim_set_var('python3_host_prog', '~/scoop/apps/python/current/python.exe')

vim.o.termguicolors = true

local config_values = require('config-values')

require('plugins')
require('appearance')
require('keybindings')
require('coc_config')

-- detect the filetype
vim.api.nvim_set_option('filetype', 'on')

-- detect ex-commands for file
-- vim.api.nvim_set_option('plugin', 'on')
-- determine indent
-- vim.api.nvim_set_option('indent', 'on')

-- highlight syntax
vim.api.nvim_set_option('syntax', 'on')

vim.api.nvim_set_option('timeoutlen', 400)

-- use LSP for omnifunc for typescript
vim.api.nvim_command('autocmd Filetype typescript setlocal omnifunc=v:lua.vim.lsp.omnifunc')


-- use english vim
-- vim.api.nvim_command('language en_US')

vim.api.nvim_set_option('ignorecase', true)
vim.api.nvim_set_option('smartcase', true)

vim.api.nvim_set_var('fzfSwitchProjectWorkspaces', config_values.workspace_folders)
vim.api.nvim_set_var('fzfSwitchProjectAlwaysChooseFile', false)



-- TEMPORARY
vim.g.coc_global_extensions={ 'coc-omnisharp', 'coc-explorer', 'coc-clangd' }
