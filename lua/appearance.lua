vim.api.nvim_command('language en_US')

-- how many spaces wide a tab is displayed
vim.bo.tabstop = 4
vim.o.tabstop = 4

-- how many spaces (or equivalents) is one indent
vim.bo.shiftwidth = 4
vim.o.shiftwidth = 4

-- use spaces instead of tabs :(
vim.bo.expandtab = true
vim.o.expandtab = true

-- open windows to the right or below
vim.o.splitright = true
vim.o.splitbelow = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.cursorline = true


vim.api.nvim_set_var("chadtree_settings", {
	['theme.text_colour_set'] = 'nord',
})
