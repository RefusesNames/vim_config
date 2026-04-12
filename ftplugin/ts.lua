if (not vim.g.loaded_ts_ls) then
	vim.g.loaded_ts_ls = true
	vim.lsp.enable('ts_ls')
	vim.treesitter.start()
end
