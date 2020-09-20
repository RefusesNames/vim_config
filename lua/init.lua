vim.o.termguicolors = true

require('plugins')
require('appearance')
require('keybindings')

-- detect the filetype
vim.api.nvim_set_option('filetype', 'on')

-- detect ex-commands for file
-- vim.api.nvim_set_option('plugin', 'on')
-- determine indent
-- vim.api.nvim_set_option('indent', 'on')

-- highlight syntax
vim.api.nvim_set_option('syntax', 'on')

-- use LSP for omnifunc for typescript
vim.api.nvim_command('autocmd Filetype typescript setlocal omnifunc=v:lua.vim.lsp.omnifunc')
vim.api.nvim_command('language en_US')
