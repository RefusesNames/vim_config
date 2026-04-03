vim.pack.add({
	'https://github.com/numToStr/Comment.nvim',
})

vim.api.nvim_set_keymap('n', '<leader>/', 'gcc', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', 'gc', { noremap = false, silent = true })
