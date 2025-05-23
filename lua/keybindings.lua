-- NAVIGATION
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

-- Miscellaneous
vim.api.nvim_set_keymap('n', '<leader>n', ':nohlsearch<CR>', { noremap = false, silent = true})

-- LSP
return {
	['gD'] = '<Cmd>lua vim.lsp.buf.declaration()<CR>',
	--['gd'] = '<cmd>lua require("telescope.builtin").lsp_definitions{}<CR>',
	['K'] = '<Cmd>lua vim.lsp.buf.hover()<CR>',
	--['gi'] = '<cmd>lua require("telescope.builtin").lsp_implementations{}<CR>',
	['<space>k'] = '<cmd>lua vim.lsp.buf.hover()<CR>',
	-- ['<space>k'] = '<cmd>lua vim.lsp.buf.signature_help()<CR>',
	['<space>wa'] = '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
	['<space>wr'] = '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
	['<space>wl'] = '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
	['<space>D'] = '<cmd>lua vim.lsp.buf.type_definition()<CR>',
	['<space>rn'] = '<cmd>lua vim.lsp.buf.rename()<CR>',
	--['gr'] = '<cmd>lua require("telescope.builtin").lsp_references{}<CR>',
	-- ['<space>d'] = '<cmd>lua require("telescope.builtin").diagnostics{}<CR>',
	['<space>d'] = '<cmd>lua vim.diagnostic.open_float()<CR>',
	['[d'] = '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
	[']d'] = '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
	['<space>q'] = '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',
	['<space>a'] = '<cmd>lua vim.lsp.buf.code_action()<CR>',
	-- ['<space>a'] = '<cmd>lua require("telescope.builtin").lsp_code_actions{}<CR>',
}
