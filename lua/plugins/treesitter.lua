return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		-- ft = { 'cpp', 'cs', 'markdown', 'xml', 'lua', 'typescript', 'typescriptreact', 'ps1' },
		-- cmd = { 'TSInstall', 'TSUpdate' },
		-- run = ':TSUpdate',
		branch = 'main',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').install{
				'cpp',
				'lua',
				'c_sharp',
				'markdown',
				'typescript',
				'tsx',
				'powershell',
				'razor'}
			-- require('nvim-treesitter.configs').setup{
			-- 	ensure_installed = { 'cpp', 'lua', 'c_sharp', 'markdown', 'typescript', 'tsx', 'powershell', 'razor' },
			-- 	highlight = { enable = true },
			-- 	incremental_selection = { enable = true },
			-- 	textobjects = { enable = true },
			-- 	rainbow = {
			-- 		enable = true,
			-- 		extended_mode = true
			-- 	}
			-- }
		end,
	},
	"hiphish/rainbow-delimiters.nvim",
}
