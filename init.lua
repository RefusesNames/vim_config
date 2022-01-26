-- quality of life
vim.api.nvim_command('command! ReloadConfig :luafile $MYVIMRC')

require('plugins')

require('onenord').setup()

require('nvim-tree').setup()

require('keybindings')

require('appearance')

require('autocompletion')

vim.api.nvim_command('autocmd Filetype ts setlocal omnifunc=v:lua.vim.lsp.omnifunc')
vim.api.nvim_command('autocmd Filetype cs setlocal omnifunc=v:lua.vim.lsp.omnifunc')
