return {
	{
		'numToStr/Comment.nvim',
		config = function()
			vim.api.nvim_set_keymap('n', '<leader>/', 'gcc', { noremap = false, silent = true })
			vim.api.nvim_set_keymap('v', '<leader>/', 'gc', { noremap = false, silent = true })
		end
	}
}
