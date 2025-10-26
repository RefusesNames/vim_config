return
{
	{
		'neovim/nvim-lspconfig',-- Collection of configurations for built-in LSP client
		lazy = true,
		ft = { 'cs', 'rust', 'cpp', 'typescript', 'typescriptreact', 'ps1', 'lua' },
		keys = {
			{ 'gD', vim.lsp.buf.declaration, desc = 'Go to declaration' },
			{ 'gd', vim.lsp.buf.definition, desc = 'Go to definition' },
			--['gd'] = '<cmd>lua require("telescope.builtin").lsp_definitions{}<CR>',
			{ 'gi', function()
				require("telescope.builtin").lsp_implementations{}
			end, desc = 'Go to implementations' },
			{ 'gr', function()
				require("telescope.builtin").lsp_references{}
			end, desc = 'Go to references' },
			{ '<leader>k', vim.lsp.buf.hover, desc = 'Open tooltip' },
			{ '<leader>wa', vim.lsp.buf.add_workspace_folder, desc = 'Add workspace folder' },
			{ '<leader>wr', vim.lsp.buf.remove_workspace_folder, desc = 'Remove workspace folder' },
			{ '<leader>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, desc = 'List workspace folders' },
			{ '<leader>D', vim.lsp.buf.type_definition, desc = 'Show type definition' },
			{ '<leader>rn', vim.lsp.buf.rename, desc = 'Rename' },
			{ '<leader>d', vim.diagnostic.open_float, desc = 'Open float?' },
			{ '<leader>p', vim.lsp.diagnostic.goto_prev, desc = 'Go to previous diagnostic' },
			{ '<leader>n', vim.lsp.diagnostic.goto_next, desc = 'Go to next diagnostic' },
			{ '<leader>a', vim.lsp.buf.code_action, desc = 'Execute code action' },
		},
		config = function()
			vim.diagnostic.config({ virtual_text = false })

			require('plugins/lsp_config/powershell_es')
			require('plugins/lsp_config/lua_ls')
			require('plugins/lsp_config/ts_ls')
			

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
		end,
		dependencies = {
			'hrsh7th/nvim-cmp', -- Autocompletion plugin
			'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
			'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
			'L3MON4D3/LuaSnip', -- Snippets plugin
			'folke/neodev.nvim', -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
		}
	},
}
