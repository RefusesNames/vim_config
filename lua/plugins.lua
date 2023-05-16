
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
        'pianocomposer321/yabs.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('yabs'):setup({
                opts = {
                output_types = {
                    quickfix = {
                        open_on_run = 'always',
                    },
                },
            },
        })
    end
    }

    use {
        'tamago324/lir.nvim',
        requires = { 
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        },
        config = function ()
            local actions = require'lir.actions'
            local mark_actions = require 'lir.mark.actions'
            local clipboard_actions = require'lir.clipboard.actions'

            require'lir'.setup {
                show_hidden_files = false,
		devicons = {
			enable = true,
			highlight_dirname = true
		},
                mappings = {
                    ['<CR>']  = actions.edit,
                    ['l']     = actions.edit,
                    ['<C-s>'] = actions.split,
                    ['<C-v>'] = actions.vsplit,
                    ['<C-t>'] = actions.tabedit,

                    ['h']     = actions.up,
                    ['q']     = actions.quit,
                    ['<Esc>'] = actions.quit,

                    ['A']     = actions.mkdir,
                    ['a']     = actions.newfile,
                    ['r']     = actions.rename,
                    ['@']     = actions.cd,
                    ['Y']     = actions.yank_path,
                    ['.']     = actions.toggle_show_hidden,
                    ['D']     = actions.delete,

                    ['J'] = function()
                        mark_actions.toggle_mark()
                        vim.cmd('normal! j')
                    end,
                    ['yy'] = clipboard_actions.copy,
                    ['dd'] = clipboard_actions.cut,
                    ['p'] = clipboard_actions.paste,
                },
                float = {
                    winblend = 0,
                    curdir_window = {
                        enable = false,
                        highlight_dirname = false
                    },
                },
                hide_cursor = true,
                on_init = function()
                    -- use visual mode
                    vim.api.nvim_buf_set_keymap(
                    0,
                    "x",
                    "J",
                    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
                    { noremap = true, silent = true }
                    )

                    -- echo cwd
                    vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
                end,
            }

            -- custom folder icon
            require'nvim-web-devicons'.set_icon({
                lir_folder_icon = {
                    icon = "",
                    color = "#7ebae4",
                    name = "LirFolderNode"
                }
            })
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    file_ignore_patterns = { ".git", ".svn" }
                }
            }
            telescope.load_extension('yabs')
        end
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
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup{
                ensure_installed = { 'cpp', 'lua', 'c_sharp' },
                highlight = { enable = true },
                incremental_selection = { enable = true },
                textobjects = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true
                }
            }
        end,
        requires = {
            { 'p00f/nvim-ts-rainbow' }
        }

    }

    use {
        'gpanders/editorconfig.nvim'
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
