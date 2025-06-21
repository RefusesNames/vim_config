-- see https://aaronbos.dev/posts/debugging-csharp-neovim-nvim-dap
return {
	{
		-- source: https://github.com/mfussenegger/nvim-dap
		'mfussenegger/nvim-dap',
		lazy = true,
		-- ft = { 'cs' },
		keys = {
			{ '<F5>', function() require('dap').continue() end, desc = 'Run debugger' },
			{ '<F10>', function() require('dap').step_over() end, desc = 'Step over' },
			{ '<F11>', function() require('dap').step_into() end, desc = 'Stop into' },
			{ '<F12>', function() require('dap').step_out() end, desc = 'Step out' },
			{ '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
			{ '<leader>B',
				function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
				desc = 'Set breakpoint with condition' },
			{ '<leader>lp',
				function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
				desc = 'Set breakpoint with log message' },
			{ '<leader>dr', function() require('dap').repl_open() end, desc = 'Open REPL' },
			{ '<leader>dl', function() require('dap').run_last() end, desc = 'Run last'},
		},
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
		lazy = true,
		ft = { 'cs' },
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

			dapui.setup({
				icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { '<CR>', '<2-LeftMouse>' },
					open = 'o',
					remove = 'd',
					edit = 'e',
					repl = 'r',
					toggle = 't',
				},
				-- Use this to override mappings for specific elements
				element_mappings = {
					-- Example:
					-- stacks = {
						--   open = '<CR>',
						--   expand = 'o',
						-- }
					},
					-- Expand lines larger than the window
					-- Requires >= 0.7
					expand_lines = vim.fn.has('nvim-0.7') == 1,
					-- Layouts define sections of the screen to place windows.
					-- The position can be 'left', 'right', 'top' or 'bottom'.
					-- The size specifies the height/width depending on position. It can be an Int
					-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
					-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
					-- Elements are the elements shown in the layout (in order).
					-- Layouts are opened in order so that earlier layouts take priority in window sizing.
					layouts = {
						{
							elements = {
								-- Elements can be strings or table with id and size keys.
								{ id = 'scopes', size = 0.25 },
								'breakpoints',
								'stacks',
								'watches',
							},
							size = 40, -- 40 columns
							position = 'left',
						},
						{
							elements = {
								'repl',
								'console',
							},
							size = 0.25, -- 25% of total lines
							position = 'bottom',
						},
					},
					controls = {
						-- Requires Neovim nightly (or 0.8 when released)
						enabled = true,
						-- Display controls in this element
						element = 'repl',
						icons = {
							pause = '',
							play = '',
							step_into = '',
							step_over = '',
							step_out = '',
							step_back = '',
							run_last = '↻',
							terminate = '□',
						},
					},
					floating = {
						max_height = nil, -- These can be integers or a float between 0 and 1.
						max_width = nil, -- Floats will be treated as percentage of your screen.
						border = 'single', -- Border style. Can be 'single', 'double' or 'rounded'
						mappings = {
							close = { 'q', '<Esc>' },
						},
					},
					windows = { indent = 1 },
					render = {
						max_type_length = nil, -- Can be integer or nil.
						max_value_lines = 100, -- Can be integer or nil.
					}
				})
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
