-- quality of life
vim.api.nvim_command('command! ReloadConfig :luafile $MYVIMRC')

vim.api.nvim_command('language en_US')

require('plugins')

require('onenord').setup()

require('nvim-tree').setup()

require('keybindings')
