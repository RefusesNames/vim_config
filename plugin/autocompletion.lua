vim.pack.add({
	-- autocompletion
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/hrsh7th/nvim-cmp',
	'https://github.com/hrsh7th/cmp-nvim-lsp',
	'https://github.com/saadparwaiz1/cmp_luasnip',
	'https://github.com/L3MON4D3/LuaSnip',
	'https://github.com/folke/lazydev.nvim',
})
vim.keymap.set('n','gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n','gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
-- 			--['gd'] = '<cmd>lua require("telescope.builtin").lsp_definitions{}<CR>',
vim.keymap.set('n','gi',
	function()
		require("telescope.builtin").lsp_implementations{}
	end, { desc = 'Go to implementations' })
vim.keymap.set('n','gr', function()
		require("telescope.builtin").lsp_references{}
	end, { desc = 'Go to references' })
vim.keymap.set('n','<leader>k', vim.lsp.buf.hover, { desc = 'Open tooltip' })
vim.keymap.set('n','<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
vim.keymap.set('n','<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
vim.keymap.set('n','<leader>wl', function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = 'List workspace folders' })
vim.keymap.set('n','<leader>D', vim.lsp.buf.type_definition, { desc = 'Show type definition' })
vim.keymap.set('n','<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n','<leader>d', vim.diagnostic.open_float, { desc = 'Open float?' })
-- vim.keymap.set('n','<leader>p', vim.lsp.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
-- vim.keymap.set('n','<leader>n', vim.lsp.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n','<leader>a', vim.lsp.buf.code_action, { desc = 'Execute code action' })

vim.diagnostic.config({ virtual_text = false })

-- luasnip setup
local luasnip = require 'luasnip'
require('luasnip.loaders.from_snipmate').load()


-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-k>'] = cmp.mapping.scroll_docs(-4),
		['<C-j>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}
