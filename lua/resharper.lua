local Util = require('util')

local function get_project_file()
	local current_folder = vim.fn.expand('%:p:h')

	print('Starting to look for project file in folder: ' .. current_folder)
	return Util.find_file_in_parent_dirs(current_folder, '.csproj')
end

local function read_success(resharper_data)
	return resharper_data.runs[1].invocations[1].executionSuccessful
end

local severity_map = {
  ERROR = "E",
  WARNING = "W",
  SUGGESTION = "I",
  HINT = "I",
  INFO = "I",
}

local function map_severity(rs_severity)
  return severity_map[rs_severity] or "I"
end

local function transform_for_quickfix(resharper_result_entry, root)
	local file_path = root .. "/" ..resharper_result_entry.locations[1].physicalLocation.artifactLocation.uri
	local line_number = resharper_result_entry.locations[1].physicalLocation.region.startLine
	local column_number = resharper_result_entry.locations[1].physicalLocation.region.startColumn
	local message = resharper_result_entry.message.text

	return
	{
		filename = file_path,
		lnum = line_number,
		col = column_number,
		text = message,
		type = map_severity(resharper_result_entry.level)
	}
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
		.. ' --no-build --output=' .. tmp_file_name .. ' --include=' .. current_file
	print(command)
	vim.fn.system(command)

	local resharper_data = Util.read_json_file(tmp_file_name)

	local success = read_success(resharper_data)
	if not success then
		local ok, err = os.rename(tmp_file_name, "resharper_error.txt")
		if not ok then
			vim.notify("Failed to move file: " .. err, vim.log.levels.ERROR)
		end
		print('ReSharper execution failed. Check the file "resharper_error.txt" for details.')
		return
	end

	local results = resharper_data.runs[1].results

	local items = {}

	local current_folder = vim.fs.dirname(project_file)
	for _, issue in ipairs(results) do
		local item = transform_for_quickfix(issue, current_folder)
		table.insert(items, item)
	end

	vim.fn.setqflist({}, " ", { title = "ReSharper", items = items, })

	os.remove(tmp_file_name)
	vim.cmd('copen')
end


vim.api.nvim_create_user_command('ReSharper', execute_resharper, { force = true })
