return {
	'tamago324/lir.nvim',
	dependencies = { 
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
