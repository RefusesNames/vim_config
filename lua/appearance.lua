
vim.wo.number = true
vim.wo.relativenumber = true

vim.api.nvim_command('colorscheme pencil')

-- show popupmenu (also when only one entry) and preview for omnifunc
vim.o.completeopt = 'menu,menuone,preview'

-- how many spaces wide a tab is displayed
vim.bo.tabstop = 2
vim.o.tabstop = 2

-- how many spaces (or equivalents) is one indent
vim.bo.shiftwidth = 2
vim.o.shiftwidth = 2
