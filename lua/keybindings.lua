-- TODO could be simplified with vimpeccable


-- LSP
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'g0', ':lua vim.lsp.buf.document_symbol()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gw', ':lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })


-- more convenient omnifunc
vim.api.nvim_set_keymap('i', '<C-A>', '<C-X><C-O>', { noremap = false, silent = true })


-- NAVIGATION
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W>h', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W>j', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W>k', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W>l', { noremap = false, silent = true })
