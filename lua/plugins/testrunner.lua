return {
	{
		'nvim-neotest/neotest',
		lazy = true,
		ft = { 'cs' },
		dependencies = {
			'Issafalcon/neotest-dotnet',
			'nvim-neotest/nvim-nio',
			'nvim-lua/plenary.nvim',
			'antoinemadec/FixCursorHold.nvim',
			'nvim-treesitter/nvim-treesitter'
		},
		config = function()
			require('neotest').setup({
				adapters = {
					require('neotest-dotnet')({
						-- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
						-- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
						--       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
						discovery_root = "project" -- Default
						-- discovery_root = 'solution'
					})
				}
			})

			vim.api.nvim_create_user_command(
				'TestRunSingle',
				function() require('neotest').run.run() end,
				{ force = true })

			vim.api.nvim_create_user_command(
				'TestDebugSingle',
				function() require('neotest').run.run({strategy = 'dap'}) end,
				{ force = true })

			vim.api.nvim_create_user_command(
				'TestRunFile',
				function() require('neotest').run.run({vim.fn.expand("%")}) end,
				{ force = true })

			vim.api.nvim_create_user_command(
				'TestRunLast',
				function() require('neotest').run.run_last() end,
				{ force = true })

			vim.api.nvim_create_user_command(
				'TestDebugLast',
				function() require('neotest').run.run_last({strategy = 'dap'}) end,
				{ force = true })

			vim.api.nvim_create_user_command(
				'TestWatch',
				function() require('neotest').watch.watch() end,
				{ force = true })


			vim.api.nvim_create_user_command(
				'TestWatchToggle',
				function() require('neotest').watch.toggle() end,
				{ force = true })

			vim.api.nvim_create_user_command(
				'TestSummaryToggle',
				function() require('neotest').summary.toggle() end,
				{ force = true })


			vim.api.nvim_create_user_command(
				'TestJumpNextFailed',
				function() require('neotest').jump.next({ status = "failed" }) end,
				{ force = true })

			vim.api.nvim_create_user_command(
				'TestJumpPreviousFailed',
				function() require('neotest').jump.prev({ status = "failed" }) end,
				{ force = true })

		end
	}
}
