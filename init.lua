-- quality of life
vim.api.nvim_command('command! ReloadConfig :luafile $MYVIMRC')

vim.g.mapleader = ' '
local is_windows = vim.loop.os_uname().version:match("Windows")
if is_windows then
	-- Set PowerShell-specific settings
	vim.opt.shell = 'pwsh'
	vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
	vim.opt.shellquote = ''
	vim.opt.shellxquote = ''
	vim.opt.shellpipe = '| Out-File -Encoding UTF8'
end

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

require('keybindings')

require('appearance')

require('resharper')

-- vim.api.nvim_command('autocmd Filetype ts setlocal omnifunc=v:lua.vim.lsp.omnifunc')
-- vim.api.nvim_command('autocmd Filetype cs setlocal omnifunc=v:lua.vim.lsp.omnifunc')
-- vim.api.nvim_command('autocmd TermOpen * setlocal nonumber norelativenumber')

vim.api.nvim_create_user_command('Notes', 'e ~/notes.md', { force = true })
vim.api.nvim_create_user_command('Vgit', function() require('neogit').open({ kind = 'vsplit' }) end, { force = true })
vim.api.nvim_create_user_command('Sgit', function() require('neogit').open({ kind = 'split' }) end, { force = true })
vim.api.nvim_create_user_command('Tgit', function ()require('neogit').open({ kind = 'tab' }) end, { force = true })


-- Function to reload NeoVim configuration and ftplugin settings
function ReloadConfig()
	-- Unload all Lua modules
	for name,_ in pairs(package.loaded) do
		if name:match('^user') or name:match('^plugins') then
			package.loaded[name] = nil
		end
	end

	-- Source the init.lua file
	dofile(vim.env.MYVIMRC)

	-- Reload ftplugin settings for all open buffers
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
			vim.cmd('doautocmd FileType ' .. ft)
		end
	end
end
-- Create a command to reload the configuration
vim.api.nvim_create_user_command('ReloadConfig', 'lua ReloadConfig()', {})
