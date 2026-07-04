return 
{
	{
		'nvim-telescope/telescope.nvim',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ '<leader><space>', require('telescope.builtin').find_files,
				desc = 'Fuzzy search a file' },
			{ '<leader>c', function()
				require('telescope.builtin').find_files{ cwd = vim.fn.stdpath('config') }
			end,
				desc = 'Fuzzy search in Neovim configuration' },
			{ '<leader>o', require('telescope.builtin').treesitter,
				desc = 'Fuzzy search in tree' },
			{ '<leader>ff', require('telescope.builtin').live_grep,
				desc = 'Fuzzy search in all files' },
			{ '<leader>fb', require('telescope.builtin').current_buffer_fuzzy_find,
				desc = 'Fuzzy search in current buffer' },
			{ '<leader>gb', require('telescope.builtin').buffers,
				desc = 'Fuzzy search for buffer' },
			{ '<leader>m', function()
					require('telescope.builtin').treesitter{ symbols='method' }
				end,
				desc = 'Fuzzy search in methods' },
			{ 'gvd', function()
					require"telescope.builtin".lsp_definitions({jump_type="vsplit"})
				end,
				desc = 'Go to definition in vertical split'},
			{ 'ghd', function()
					require"telescope.builtin".lsp_definitions({jump_type="split"})
				end,
				desc = 'Go to definition in horizontal split'},
				
			-- less often used commands:
			{ '<leader>t', function()
				local pickers = require("telescope.pickers")
				local finders = require("telescope.finders")
				local conf = require("telescope.config").values
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")
				local items = {
					{ name = "Git Status", value = "git_status" },
					{ name = "Buffers", value = "buffers" },
					{ name = "Current Buffer Fuzzy Find", value = "current_buffer_fuzzy_find" },
				}
				pickers.new({}, {
					prompt_title = "Choose action",
					finder = finders.new_table({
						results = items,
						entry_maker = function(entry)
							return {
								value = entry.value,
								display = entry.name,
								ordinal = entry.name,
							}
						end,
					}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(_, map)
						map("i", "<CR>", function(prompt_bufnr)
							local entry = action_state.get_selected_entry()
							actions.close(prompt_bufnr)

							if entry.value == "git_status" then
								require("telescope.builtin").git_status()
							elseif entry.value == "buffers" then
								require("telescope.builtin").buffers()
							elseif entry.value == "current_buffer_fuzzy_find" then
								require("telescope.builtin").current_buffer_fuzzy_find()
							end
						end)
						return true
					end,
				}):find()

			end }
		},
		config = function()
			local telescope = require('telescope')
			telescope.setup {
				defaults = {
					file_ignore_patterns = { '^.git', '^.svn', '^bin', '^obj', '^target' }
				}
			}
		end
	}
}
