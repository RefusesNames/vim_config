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

