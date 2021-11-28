
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
	use { 'kyazdani42/nvim-tree.lua' }
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

	if packer_bootstrap then
		require('packer').sync()
	end
end)
