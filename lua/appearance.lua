-- how many spaces wide a tab is displayed
vim.bo.tabstop = 2
vim.o.tabstop = 2

-- how many spaces (or equivalents) is one indent
vim.bo.shiftwidth = 2
vim.o.shiftwidth = 2

-- use spaces instead of tabs :(
vim.bo.expandtab = false
vim.o.expandtab = false

-- open windows to the right or below
vim.o.splitright = true
vim.o.splitbelow = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.cursorline = true

vim.opt.colorcolumn = '90'

vim.api.nvim_set_var("chadtree_settings", {
	['theme.text_colour_set'] = 'nord',
})
