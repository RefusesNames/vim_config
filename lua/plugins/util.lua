return {
	'gpanders/editorconfig.nvim',
	{
		'numToStr/Comment.nvim',
		config = function()
			vim.api.nvim_set_keymap('n', '<leader>/', 'gcc', { noremap = false, silent = true })
			vim.api.nvim_set_keymap('v', '<leader>/', 'gc', { noremap = false, silent = true })
		end
	}

	-- NO IDEA IF I STILL WANT THIS
	-- {
	-- 	'pianocomposer321/yabs.nvim',
	-- 	dependencies = { 'nvim-lua/plenary.nvim' },
	-- 	opts = {
	-- 		output_types = {
	-- 			quickfix = {
	-- 				open_on_run = 'always',
	-- 			},
	-- 		},
	-- 	}
	-- 	-- config = function()
	-- 	-- 	require('yabs'):setup({
	-- 	-- 		opts = {
	-- 	-- 			output_types = {
	-- 	-- 				quickfix = {
	-- 	-- 					open_on_run = 'always',
	-- 	-- 				},
	-- 	-- 			},
	-- 	-- 		},
	-- 	-- 	})
	-- 	-- end
	-- },
}
