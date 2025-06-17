return {
	{
		'nvim-neotest/neotest',
		lazy = true,
		ft = { 'cs' },
		dependencies = {
			'Issafalcon/neotest-dotnet'
		},
		config = function()
			require('neotest').setup({
				adapters = {
					require('neotest-dotnet')({
						-- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
						-- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
						--       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
						-- discovery_root = "project" -- Default
						discovery_root = 'solution'
					})
				}
			})
		end
	}
}
