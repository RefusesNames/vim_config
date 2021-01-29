vim.o.termguicolors = true

local config_values = require('config-values')

require('plugins')
require('appearance')
require('keybindings')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
	indent = { enable = true },
}

-- detect the filetype
vim.api.nvim_set_option('filetype', 'on')

-- detect ex-commands for file
-- vim.api.nvim_set_option('plugin', 'on')
-- determine indent
-- vim.api.nvim_set_option('indent', 'on')

-- highlight syntax
vim.api.nvim_set_option('syntax', 'on')

vim.api.nvim_set_option('timeoutlen', 400)

-- use LSP for omnifunc for typescript
vim.api.nvim_command('autocmd Filetype typescript setlocal omnifunc=v:lua.vim.lsp.omnifunc')


-- use english vim
-- vim.api.nvim_command('language en_US')


vim.api.nvim_set_var('fzfSwitchProjectWorkspaces', config_values.workspace_folders)
vim.api.nvim_set_var('fzfSwitchProjectAlwaysChooseFile', false)
