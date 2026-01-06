local Util = require('util')

local function get_project_file()
	local current_folder = vim.fn.expand('%:p:h')

	print('Starting to look for project file in folder: ' .. current_folder)
	return Util.find_file_in_parent_dirs(current_folder, '.csproj')
end

local function execute_resharper()
	-- TODO: use `vim.loop.spawn` to do this asynchronously
	-- (see https://github.com/lewis6991/async.nvim#example and `:h vim.loop`)
	-- (maybe use vim.loop.new_thread?)
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

	vim.cmd('cfile ' .. tmp_file_name, false)

	vim.o.errorformat = errorformat_save
	os.remove(tmp_file_name)
	vim.cmd('copen')
end

vim.api.nvim_create_user_command('ReSharper', execute_resharper, { force = true })
