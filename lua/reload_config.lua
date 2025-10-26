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
