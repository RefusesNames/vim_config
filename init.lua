-- quality of life
vim.api.nvim_command('command! ReloadConfig :luafile $MYVIMRC')

-- temporary
vim.api.nvim_exec(
[[
let mapleader = "\<Space>"
if has("win64") || has("win32")
	" see ':h shell-powershell' and
	" https://github.com/junegunn/vim-plug/issues/895#issuecomment-544130552
	let &shell = has('win64') ? 'pwsh.exe': 'powershell.exe'
	set shellquote= shellpipe=\| shellxquote=
	set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
	set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif
if exists("g:neovide")
	set guifont=FiraCode\ Nerd\ Font:h11
endif
]],
true)

local local_config = require('local_config')

vim.o.swapfile = true
vim.o.dir = local_config.tmp_path

vim.o.ignorecase = true
vim.o.smartcase = true

vim.filetype.add({
	extension = {
		xaml = "xaml"
	}
})
vim.api.nvim_create_autocmd(
	{"BufEnter", "BufWinEnter"},
	{
		pattern = { "*.xaml" },
		command = "set syntax=xml"
	}
)

require('plugin_manager')

require('onenord').setup()

require('keybindings')

require('appearance')

require('autocompletion')

require('resharper')

-- vim.api.nvim_command('autocmd Filetype ts setlocal omnifunc=v:lua.vim.lsp.omnifunc')
-- vim.api.nvim_command('autocmd Filetype cs setlocal omnifunc=v:lua.vim.lsp.omnifunc')
-- vim.api.nvim_command('autocmd TermOpen * setlocal nonumber norelativenumber')

vim.api.nvim_create_user_command('Notes', 'e ~/notes.md', { force = true })
vim.api.nvim_create_user_command('Vgit', function() require('neogit').open({ kind = 'vsplit' }) end, { force = true })
vim.api.nvim_create_user_command('Sgit', function() require('neogit').open({ kind = 'split' }) end, { force = true })
vim.api.nvim_create_user_command('Tgit', function ()require('neogit').open({ kind = 'tab' }) end, { force = true })
