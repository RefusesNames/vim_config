return 
{
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local telescope = require('telescope')
			telescope.setup {
				defaults = {
					file_ignore_patterns = { ".git", ".svn", "bin", "obj", "target" }
				}
			}
			-- telescope.load_extension('yabs')
			-- vim.keymap.set('n', '<leader>t', ':Telescope yabs tasks<CR>', { noremap = false, silent = true })
			vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files)
			vim.keymap.set('n', '<leader>c', function()
				require('telescope.builtin').find_files{ cwd = vim.fn.stdpath('config') }
			end)
			vim.keymap.set('n', '<leader>o', require("telescope.builtin").treesitter)
			vim.keymap.set('n', '<leader>f', require("telescope.builtin").live_grep)
			vim.keymap.set('n', '<leader>m', function()
				require("telescope.builtin").treesitter{ symbols="method" }
			end)
		end
	}
}
