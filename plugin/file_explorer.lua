vim.pack.add({
	'https://github.com/stevearc/oil.nvim',
	'https://github.com/nvim-tree/nvim-web-devicons',
})

require('oil').setup{
	columns = { "icon" },
	keymaps = {
		["<C-v>"] = { "actions.select", opts = { vertical = true } },
		["<C-x>"] = { "actions.select", opts = { horizontal = true } },
	},
	view_options = {
		show_hidden = true,
	}
}

vim.keymap.set('n', '<leader>e',
	require('oil').open_float,
	{ desc = 'Open parent directory' })
