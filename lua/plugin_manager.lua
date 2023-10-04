local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
--	{
--		'pianocomposer321/yabs.nvim',
--		dependencies = { 'nvim-lua/plenary.nvim' },
--		opts = {
--			output_types = {
--				quickfix = {
--					open_on_run = 'always',
--				},
--			},
--		}
--		-- config = function()
--		-- 	require('yabs'):setup({
--		-- 		opts = {
--		-- 			output_types = {
--		-- 				quickfix = {
--		-- 					open_on_run = 'always',
--		-- 				},
--		-- 			},
--		-- 		},
--		-- 	})
--		-- end
--	},
--	{
--		'nvim-telescope/telescope.nvim',
--		dependencies = { 'nvim-lua/plenary.nvim' },
--		config = function()
--			local telescope = require('telescope')
--			telescope.setup {
--				defaults = {
--					file_ignore_patterns = { ".git", ".svn" }
--				}
--			}
--			telescope.load_extension('yabs')
--		end
--	},

--	{
--		'nvim-lualine/lualine.nvim',
--		dependencies = { 'kyazdani42/nvim-web-devicons' },
--		config = function()
--			require('lualine').setup{}
--		end
--	},

--	'tpope/vim-fugitive',

--	{
--		'nvim-treesitter/nvim-treesitter',
--		-- run = ':TSUpdate',
--		config = function()
--			require('nvim-treesitter.configs').setup{
--				ensure_installed = { 'cpp', 'lua', 'c_sharp' },
--				highlight = { enable = true },
--				incremental_selection = { enable = true },
--				textobjects = { enable = true },
--				rainbow = {
--					enable = true,
--					extended_mode = true
--				}
--			}
--		end,
--		dependencies = {
--			{ 'p00f/nvim-ts-rainbow' }
--		}

--	},

--	'gpanders/editorconfig.nvim',

--	-- LSP and Completion
--	use 'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
--	use 'hrsh7th/nvim-cmp', -- Autocompletion plugin
--	use 'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
--	use 'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
--	use 'L3MON4D3/LuaSnip', -- Snippets plugin
}
local lazy = require('lazy')
lazy.setup('plugins')
return lazy

