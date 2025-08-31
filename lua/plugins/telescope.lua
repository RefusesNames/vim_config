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
