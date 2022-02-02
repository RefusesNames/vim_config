
-- packer
local file_system = vim.fn
local packer_install_dir = file_system.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_repo = 'https://github.com/wbthomason/packer.nvim'
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

local packer_bootstrap = false

if file_system.empty(file_system.glob(packer_install_dir)) > 0 then
	vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
	-- vim.api.nvim_command(install_cmd)
	packer_bootstrap = vim.api.nvim_command(install_cmd)
	-- packer_bootstrap = file_system.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_install_dir})
	vim.api.nvim_command('packadd packer.nvim')
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use { 'wbthomason/packer.nvim' }
	use { 'rmehri01/onenord.nvim' }

	use {
		'ms-jpq/chadtree',
		branch = 'chad',
		run = 'python3 -m chadtree deps',
	}

	use {
	    'numToStr/Comment.nvim',
	    config = function()
		    require('Comment').setup()
	    end
	}

	use {
		'junegunn/fzf.vim',
		requires = {
			{ 'junegunn/fzf' }
		}
	}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup{}
		end
	}

	use { 'tpope/vim-fugitive' }

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- LSP and Completion
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets plugin


	if packer_bootstrap then
		require('packer').sync()
	end
end)
