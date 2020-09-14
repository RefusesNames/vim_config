
vim.wo.number = true
vim.wo.relativenumber = true

vim.api.nvim_command('colorscheme pencil')

-- show popupmenu (also when only one entry) and preview for omnifunc
vim.o.completeopt = 'menu,menuone,preview'
