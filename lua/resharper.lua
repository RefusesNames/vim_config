function get_project_file_in_folder(folder_path)
	print('Looking for project file in folder: ' .. folder_path)

	local project_file_names = {}
	for directory_item in vim.fs.dir(folder_path) do
		if string.match(directory_item, '%S+.csproj$') then
			project_file_names[#project_file_names + 1] = directory_item
		end
	end

	local names_found = table.getn(project_file_names)
	if names_found == 0 then
		return nil
	elseif names_found == 1 then
		return folder_path .. '\\' .. project_file_names[1]
	else
		local result = nil
		vim.ui.select(project_file_names, {
			prompt = 'Select the solution:',
		}, function(selected_project_file)
			result = folder_path .. '\\' .. selected_project_file
		end)
		return result
	end
end

function get_project_file()
	local current_folder = vim.fn.expand('%:p:h')

	print('Starting to look for project file in folder: ' .. current_folder)
	repeat
		local project_file = get_project_file_in_folder(current_folder)

		if project_file ~= nil then
			return project_file
		end

		current_folder = string.sub(current_folder, 1, string.find(current_folder, '\\[^\\]*$') - 1)

		print('Not found, looking for project file in folder: ' .. current_folder)
	until current_folder == vim.lsp.buf.list_workspace_folders()[1]
end

function execute_resharper()
	local tmp_file_name = os.tmpname()
	local current_file = vim.fn.expand('%:t')

	local project_file = get_project_file()
	print('project file found: ' .. project_file)
	local command = 'jb inspectcode ' .. project_file
		.. ' --no-build --output=' .. tmp_file_name .. ' --format=Text --include=' .. current_file 
	print(command)
	vim.fn.system(command)

	local errorformat_save = vim.o.errorformat
	vim.o.errorformat
		= '\\ \\ \\ \\ \\ \\ %f:%l\\ %m'
		.. ',%-G%.%#' -- relevant: https://vi.stackexchange.com/a/18849

	vim.api.nvim_exec('cfile ' .. tmp_file_name, false)

	vim.o.errorformat = errorformat_save
	os.remove(tmp_file_name)
end

vim.api.nvim_create_user_command('ReSharper', execute_resharper, { force = true })
