vim.api.nvim_command('language en_US')

-- how many spaces wide a tab is displayed
vim.bo.tabstop = 2
vim.o.tabstop = 2

-- how many spaces (or equivalents) is one indent
vim.bo.shiftwidth = 2
vim.o.shiftwidth = 2

-- open windows to the right or below
vim.o.splitright = true
vim.o.splitbelow = true

vim.wo.number = true
vim.wo.relativenumber = true
