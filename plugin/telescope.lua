vim.pack.add({
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-lua/plenary.nvim',
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>o', builtin.help_tags, { desc = 'Fuzzy search in tree' })
vim.keymap.set('n', '<leader>ff', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>gb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy search in current buffer' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local telescope = require('telescope')
telescope.setup {
	defaults = {
		file_ignore_patterns = { '^.git', '^.svn', '^bin', '^obj', '^target' }
	}
}
