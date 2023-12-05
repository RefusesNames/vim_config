local nvim_lsp = require('lspconfig')

local lsp_keybindings = require('keybindings')
local local_config = require('local_config')

vim.diagnostic.config({ virtual_text = false })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=false, silent=true }

  for key_binding, command in pairs(lsp_keybindings) do
      vim.keymap.set('n', key_binding, command, opts)
  end
end

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
local pid = vim.fn.getpid()
require('lspconfig').omnisharp.setup{
	cmd = { local_config.omnisharp_path, '--languageserver', '--hostPID', tostring(pid) },
	on_attach = on_attach,
	on_new_config = function(new_config, new_root_dir)

		-- removes everything but the omnisharp path
		new_config.cmd = { unpack(new_config.cmd or {}) }

		-- Append hard-coded command arguments
		table.insert(new_config.cmd, '-z') -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
		-- vim.list_extend(new_config.cmd, { '--hostPID', tostring(vim.fn.getpid()) })
		table.insert(new_config.cmd, 'DotNet:enablePackageRestore=false')
		vim.list_extend(new_config.cmd, { '--encoding', 'utf-8' })
		-- table.insert(new_config.cmd, '--languageserver')

		-- TODO: see if the solution file was previously contained in new_config.cmd
		-- if so, use it instead of asking the user to select a solution file

		local names = {}

		for directory_item in vim.fs.dir(new_root_dir) do
			if string.match(directory_item, '%S+.sln$') then
				names[#names + 1] = directory_item
			end
		end

		if table.getn(names) ~= 1 then
			vim.ui.select(names, {
				prompt = 'Select the solution:',
			}, function(selected_solution)
				vim.list_extend(new_config.cmd, { '-s', new_root_dir .. '/' .. selected_solution })
			end)
		else
			vim.list_extend(new_config.cmd, { '-s', new_root_dir })
		end
	end
}

require('lspconfig').clangd.setup{
	on_attach = on_attach
}
require('lspconfig').rust_analyzer.setup{
	on_attach = on_attach
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
