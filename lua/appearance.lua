
vim.wo.number = true
vim.wo.relativenumber = true

-- colorscheme
local catppuccino = require('catppuccino')
catppuccino.setup({
	colorscheme = 'neon_latte',
	integrations = {
		telescope = true,
		which_key = true
	}
})
catppuccino.load()

-- status line
require('lualine').setup{
	options = {
		theme = 'catppuccino'
	}
}

-- show popupmenu (also when only one entry) and preview for omnifunc
vim.o.completeopt = 'menu,menuone,noselect'

-- how many spaces wide a tab is displayed
vim.bo.tabstop = 2
vim.o.tabstop = 2

-- how many spaces (or equivalents) is one indent
vim.bo.shiftwidth = 2
vim.o.shiftwidth = 2

-- open windows to the right or below
vim.o.splitright = true
vim.o.splitbelow = true
