return 
{
	{
		'nvim-telescope/telescope.nvim',
		lazy = true,
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ '<leader><space>', require('telescope.builtin').find_files },
			{ '<leader>c', function()
				require('telescope.builtin').find_files{ cwd = vim.fn.stdpath('config') }
			end },
			{ '<leader>o', require("telescope.builtin").treesitter },
			{ '<leader>f', require("telescope.builtin").live_grep },
			{ '<leader>m', function()
				require("telescope.builtin").treesitter{ symbols="method" }
			end },
		},
		config = function()
			local telescope = require('telescope')
			telescope.setup {
				defaults = {
					file_ignore_patterns = { "^.git", "^.svn", "^bin", "^obj", "^target" }
				}
			}
		end
	}
}
