return {
	{
		-- source: https://github.com/mfussenegger/nvim-dap
		'mfussenegger/nvim-dap',
		config = function()
			local local_config = require('local_config')
			-- TODO: docs mention that 'set noshellslash' might be required
			local dap = require('dap')
			dap.adapters.coreclr = {
				type = 'executable',
				command = local_config.netcoredbg_path,
				args = {'--interpreter=vscode'}
			}
			dap.configurations.cs = {
				{
					type = 'coreclr',
					name = 'launch - netcoredbg',
					request = 'launch',
					program = function()
						-- TODO: query the path to the dll, but provide reasonable default
						return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
					end,
				},
			}
			-- USAGE:
			--
			--   Setting breakpoints via :lua require'dap'.toggle_breakpoint().
			--   Launching debug sessions and resuming execution via :lua require'dap'.continue().
			--   Stepping through code via :lua require'dap'.step_over() and :lua require'dap'.step_into().
			--   Inspecting the state via the built-in REPL: :lua require'dap'.repl.open() or using the widget UI (:help dap-widgets)
			-- REQUIREMENTS:
			--   netcoredbg
		end
	},
	{
		-- source: https://github.com/rcarriga/nvim-dap-ui
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-neotest/nvim-nio'
		},
		config = function()
			-- this automatically starts the DAP-UI when DAP is started
			local dap, dapui = require('dap'), require('dapui')
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- USAGE:
			--
			-- Keybindings
			--   edit: e
			--   expand: <CR>
			--   open: o
			--   remove: d
			--   repl: r
			--   toggle: t
			--
			-- Evaluation
			--   evaluate expression: require('dapui').eval(<expression>)
			--   evaluate stuff under the cursor: require('dapui').eval()
			--   bind it to a key: vnoremap <M-k> <Cmd>lua require('dapui').eval()<CR>
			--
			-- Open Floating Element
			--   require('dapui').float_element(<element ID>, <optional settings>)
			--
			--   If no floating element is provided, it queries for one.
			--   Optional settings are:
			--     width: number Width of the window
			--     height: number Height of the window
			--     enter: boolean Enter the floating window
			--     position: string Position of floating window. center or nil
			--   Element IDs are:
			--     scopes: shows available scopes with variables in them
			--     stacks: displays running threads and stack frames
			--     watches: allows creation of expressions to watch
			--     breakpoints: list breakpoints
			--     repl: just a REPL
			--     console: console window used for the integrated terminal
			--
		end
	}
}
