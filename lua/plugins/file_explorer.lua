return {
	{
		'stevearc/oil.nvim',
		lazy = true,
		-- Optional dependencies
		-- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
		dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
		keys = {
			{ '<leader>e', function()
				require('oil').open_float()
			end, desc = 'Open parent directory' }
		},
		config = function()
			require('oil').setup{
				columns = { "icon" },
				keymaps = {
					['<C-h>'] = false,
				},
				view_options = {
					show_hidden = true,
				}
			}
		end
	},
}
