return
{
	{
		'neovim/nvim-lspconfig',-- Collection of configurations for built-in LSP client
		config = function()
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
			--['gd'] = '<cmd>lua require("telescope.builtin").lsp_definitions{}<CR>',
			vim.keymap.set('n', 'K', vim.lsp.buf.hover)
			vim.keymap.set('n','<leader>wa', vim.lsp.buf.add_workspace_folder)
			vim.keymap.set('n','<leader>wr', vim.lsp.buf.remove_workspace_folder)
			vim.keymap.set('n','<leader>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end)
			vim.keymap.set('n','<leader>D', vim.lsp.buf.type_definition)
			vim.keymap.set('n','<leader>rn', vim.lsp.buf.rename)
			vim.keymap.set('n','<leader>d', vim.diagnostic.open_float)
			-- vim.keymap.set('n','[d', vim.lsp.diagnostic.goto_prev)
			-- vim.keymap.set('n',']d', vim.lsp.diagnostic.goto_next)
			-- vim.keymap.set('n','<leader>q', vim.lsp.diagnostic.set_loclist)
			vim.keymap.set('n','<leader>a', vim.lsp.buf.code_action)

			--['gi'] = '<cmd>lua require("telescope.builtin").lsp_implementations{}<CR>',
			-- ['<space>k'] = '<cmd>lua vim.lsp.buf.signature_help()<CR>',
			--['gr'] = '<cmd>lua require("telescope.builtin").lsp_references{}<CR>',
			-- ['<space>d'] = '<cmd>lua require("telescope.builtin").diagnostics{}<CR>',
			-- ['<space>a'] = '<cmd>lua require("telescope.builtin").lsp_code_actions{}<CR>',
			--
			--
			--
			-- local nvim_lsp = require('lspconfig')

			local local_config = require('local_config')


			-- TODO: figure out if this way of setting keybindings is still needed
			-- local lsp_keybindings = require('keybindings')
			-- local on_attach = function(client, bufnr)
			--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
			--
			--   -- Enable completion triggered by <c-x><c-o>
			--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
			--
			--   -- Mappings.
			--   local opts = { noremap=false, silent=true }
			--
			--   for key_binding, command in pairs(lsp_keybindings) do
			--       vim.keymap.set('n', key_binding, command, opts)
			--   end
			-- end



			vim.diagnostic.config({ virtual_text = false })

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			-- local on_attach = function(client, bufnr)
			--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
			--
			--   -- Enable completion triggered by <c-x><c-o>
			--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
			--
			--   -- Mappings.
			--   local opts = { noremap=false, silent=true }
			--
			--   -- for key_binding, command in pairs(lsp_keybindings) do
			--   --     vim.keymap.set('n', key_binding, command, opts)
			--   -- end
			-- end

			-- Use a loop to conveniently call 'setup' on multiple servers and
			-- map buffer local keybindings when the language server attaches
			-- local servers = { 'omnisharp' }
			-- for _, lsp in ipairs(servers) do
			--   nvim_lsp[lsp].setup {
			--     on_attach = on_attach,
			--     flags = {
			--       debounce_text_changes = 150,
			--     }
			--   }
			-- end
			local solution_cache = {}
			local pid = vim.fn.getpid()
			require('lspconfig').omnisharp.setup{
				cmd = { local_config.omnisharp_path, '--languageserver', '--hostPID', tostring(pid) },
				-- TODO: if we don't have the `on_attach` above, can we just remove this line?
				-- on_attach = on_attach,
				on_new_config = function(new_config, new_root_dir)

					-- removes everything but the omnisharp path
					new_config.cmd = { unpack(new_config.cmd or {}) }

					-- Append hard-coded command arguments
					table.insert(new_config.cmd, '-z') -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
					table.insert(new_config.cmd, 'DotNet:enablePackageRestore=false')
					vim.list_extend(new_config.cmd, { '--encoding', 'utf-8' })

					-- use cached solution file if we opened a file with the same root directory before
					if solution_cache[new_root_dir] ~= nil then
						vim.list_extend(new_config.cmd, { '-s', new_root_dir .. '/' .. selected_solution })
						return
					end

					local names = {}

					for directory_item in vim.fs.dir(new_root_dir) do
						if string.match(directory_item, '%S+.sln$') then
							names[#names + 1] = directory_item
						end
					end

					local solutions_found = table.getn(names)

					if solutions_found == 0 then
						local project_file = ''
						for directory_item in vim.fs.dir(new_root_dir) do
							if string.match(directory_item, '%S+.csproj$') then
								project_file = directory_item
								break
							end
						end
						if project_file == '' then return end

						solution_cache[new_root_dir] = new_root_dir .. '/' .. project_file
						vim.list_extend(new_config.cmd, { '-s', new_root_dir .. '/' .. project_file })
						return
					elseif solutions_found == 1 then
						solution_cache[new_root_dir] = new_root_dir .. '/' .. names[1]
						vim.list_extend(new_config.cmd, { '-s', new_root_dir .. '/' .. names[1] })
					else
						vim.ui.select(names, {
							prompt = 'Select the solution:',
						}, function(selected_solution)
							solution_cache[new_root_dir] = new_root_dir .. '/' .. selected_solution
							vim.list_extend(new_config.cmd, { '-s', new_root_dir .. '/' .. selected_solution })
						end)
					end
				end
			}

			require('lspconfig').clangd.setup{
				-- TODO: if we don't have the `on_attach` above, can we just remove this line?
				-- on_attach = on_attach
			}
			require('lspconfig').rust_analyzer.setup{
				-- TODO: if we don't have the `on_attach` above, can we just remove this line?
				-- on_attach = on_attach
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
