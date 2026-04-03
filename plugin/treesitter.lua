vim.pack.add({
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/hiphish/rainbow-delimiters.nvim',
})

-- ft = { 'cpp', 'cs', 'markdown', 'xml', 'lua', 'typescript', 'typescriptreact', 'ps1' },

require('nvim-treesitter').install{
	'cpp',
	'lua',
	'c_sharp',
	'markdown',
	'typescript',
	'tsx',
	'powershell',
	'razor'}
