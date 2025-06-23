return
{
	{
		'seblyng/roslyn.nvim',
		ft = 'cs',
		opts = {
			config = {
				cmd = {
					"dotnet",
					vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
					"--logLevel=Information",
					"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
					"--stdio"
				},
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						csharp_enable_inlay_hints_for_types = true,
						dotnet_enable_inlay_hints_for_indexer_parameters = true,
						dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
						dotnet_enable_inlay_hints_for_other_parameters = true,
						dotnet_enable_inlay_hints_for_parameters = true,
						dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			},
		},
		lazy = true
	},
	{
		'neovim/nvim-lspconfig',-- Collection of configurations for built-in LSP client
		lazy = true,
		ft = { 'cs', 'rust', 'cpp', 'typescript', 'typescriptreact' },
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
			-- vim.keymap.set('n','<leader>q', vim.lsp.diagnostic.set_loclist)

			-- ['<space>d'] = '<cmd>lua require("telescope.builtin").diagnostics{}<CR>',
			-- ['<space>a'] = '<cmd>lua require("telescope.builtin").lsp_code_actions{}<CR>',

			local local_config = require('local_config')

			vim.diagnostic.config({ virtual_text = false })

			local solution_cache = {}
			local pid = vim.fn.getpid()

			require('lspconfig').clangd.setup{
				-- TODO: if we don't have the `on_attach` above, can we just remove this line?
				-- on_attach = on_attach
			}
			require('lspconfig').rust_analyzer.setup{
				-- TODO: if we don't have the `on_attach` above, can we just remove this line?
				-- on_attach = on_attach
			}
			require('lspconfig').ts_ls.setup{
			}

			require('lspconfig').lua_ls.setup{
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT'
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							}
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
							-- library = vim.api.nvim_get_runtime_file("", true)
						}
					})
				end,
				settings = {
					Lua = {}
				}
			}

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
		}
	},
}
