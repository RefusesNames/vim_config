-- quality of life
vim.api.nvim_command('command! ReloadConfig :luafile $MYVIMRC')

require('plugins')

require('onenord').setup()

require('nvim-tree').setup()

require('keybindings')

require('appearance')
