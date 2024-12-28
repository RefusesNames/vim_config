return {
	{
		'stevearc/oil.nvim',
		-- Optional dependencies
		-- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
		dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
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
			vim.keymap.set('n', '<leader>e', require('oil').open, { desc = 'Open parent directory' })
		end
	},
}
