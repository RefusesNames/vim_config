if (not vim.g.loaded_ps1) then
	vim.g.loaded_ps1 = true
	vim.lsp.enable('powershell_es')
	vim.treesitter.start()
end
