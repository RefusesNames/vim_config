-- TODO could be simplified with vimpeccable


-- LSP
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })


-- more convenient omnifunc
vim.api.nvim_set_keymap('i', '<C-A>', '<C-X><C-O>', { noremap = false, silent = true })


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


-- FZF
vim.api.nvim_set_keymap('n', '<space><space>', ':GitFiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>F', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>b', ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>/', ':Ag<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>c', ':Commits<CR>', { noremap = true, silent = true })


-- Rainbow Levels
vim.api.nvim_set_keymap('n', '<space>l', ':RainbowLevelsToggle<CR>', { noremap = true, silent = true })


-- Commentary
vim.api.nvim_set_keymap('n', '<space>/', 'gcc', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<space>/', 'gc', { noremap = false, silent = true })


-- Explorer
vim.api.nvim_set_keymap('n', '<space>e', ':Explore<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>r', ':Vexplore<CR>', { noremap = true, silent = true })

-- Terminal
vim.api.nvim_set_keymap('n', '<space>t', ':split | terminal<CR>', { noremap = true, silent = true })

-- Utility
vim.api.nvim_set_keymap('n', '<space>n', ':nohlsearch<CR>', { noremap = true, silent = true })
