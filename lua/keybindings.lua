-- window
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W>h', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W>j', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W>k', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W>l', { noremap = false, silent = true })
-- lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '$', 'g$', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '0', 'g0', { noremap = false, silent = true })


-- Telescope
vim.api.nvim_set_keymap('n', '<leader><space>', ':Telescope git_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope grep_string<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':Telescope git_commits<CR>', { noremap = true, silent = true })


-- Which
vim.api.nvim_set_keymap('n', '<leader>', ":WhichKey '<Space>'<CR>", { noremap = true, silent = true })


-- Rainbow Levels
vim.api.nvim_set_keymap('n', '<leader>l', ':RainbowLevelsToggle<CR>', { noremap = true, silent = true })


-- Commentary
vim.api.nvim_set_keymap('n', '<leader>/', 'gcc', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', 'gc', { noremap = false, silent = true })


-- Explorer
vim.api.nvim_set_keymap('n', '<leader>e', ':CHADopen<CR>', { noremap = true, silent = true })

-- Terminal
vim.api.nvim_set_keymap('n', '<leader>t', ':split | terminal<CR>', { noremap = true, silent = true })

-- Utility
vim.api.nvim_set_keymap('n', '<leader>n', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '_', '<C-W>_', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '|', '<C-W>|', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '=', '<C-W>=', { noremap = true, silent = true })

-- LSP
-- See `:help vim.lsp.*` for documentation on any of the below functions
local lsp_keybindings = 
{
	{
		shortcut = 'gD',
		command = '<cmd>vsplit | lua vim.lsp.buf.declaration()<CR>'
	},
  {
		shortcut = 'gd',
		command = '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>'
	},
  {
		shortcut = 'K',
		command = '<cmd>lua vim.lsp.buf.hover()<CR>'
	},
  {
		shortcut = 'gi',
		command = '<cmd>vsplit | lua vim.lsp.buf.implementation()<CR>'
	},
  {
		shortcut = '<C-i>',
		command = '<cmd>lua vim.lsp.buf.signature_help()<CR>'
	},
  {
		shortcut = '<space>wa',
		command = '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>'
	},
  {
		shortcut = '<space>wr',
		command = '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>'
	},
  {
		shortcut = '<space>wl',
		command = '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'
	},
  {
		shortcut = '<space>D',
		command = '<cmd>lua vim.lsp.buf.type_definition()<CR>'
	},
  {
		shortcut = '<space>rn',
		command = '<cmd>lua vim.lsp.buf.rename()<CR>'
	},
  {
		shortcut = '<space>ca',
		command = '<cmd>lua vim.lsp.buf.code_action()<CR>'
	},
  {
		shortcut = 'gr',
		command = '<cmd>lua vim.lsp.buf.references()<CR>'
	},
  {
		shortcut = '<space>d',
		command = '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'
	},
  {
		shortcut = '[d',
		command = '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'
	},
  {
		shortcut = ']d',
		command = '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'
	},
  {
		shortcut = '<space>q',
		command = '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>'
	},
  {
		shortcut = '<space>f',
		command = '<cmd>lua vim.lsp.buf.formatting()<CR>'
	},
}

return 
{
	lsp_keybindings = lsp_keybindings
}
