local is_windows = vim.loop.os_uname().version:match("Windows")
if is_windows then
	-- Set PowerShell-specific settings
	vim.opt.shell = 'pwsh'
	vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
	vim.opt.shellquote = ''
	vim.opt.shellxquote = ''
	vim.opt.shellpipe = '| Out-File -Encoding UTF8'
end
