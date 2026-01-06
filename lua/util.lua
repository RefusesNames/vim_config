local Util = {}

local function get_file_in_folder(folder_path, target_file_extension)
	print('Looking for project file in folder: ' .. folder_path)

	local file_candidates = {}
	local target_file_pattern = '%S+' .. target_file_extension .. '$'
	for directory_item in vim.fs.dir(folder_path) do
		if string.match(directory_item, target_file_pattern) then
			file_candidates[#file_candidates + 1] = directory_item
		end
	end

	local num_candidates_found = #file_candidates
	if num_candidates_found == 0 then
		return nil
	elseif num_candidates_found == 1 then
		return folder_path .. '\\' .. file_candidates[1]
	else
		local result = nil
		vim.ui.select(file_candidates, {
			prompt = 'Multiple candidates found in ' .. folder_path .. '. Select one:',
		}, function(selected_file)
			result = folder_path .. '\\' .. selected_file
		end)
		return result
	end
end

-- Searches for a file with the specified extension in the given directory and its parent directories.
function Util.find_file_in_parent_dirs(start_dir, target_file_extension)
	local current_folder = start_dir

	repeat
		local file = get_file_in_folder(current_folder, target_file_extension)
		if file ~= nil then
			return file
		end

		current_folder = vim.fs.dirname(current_folder)
	until current_folder == '/' or current_folder == nil

	return nil
end

return Util
