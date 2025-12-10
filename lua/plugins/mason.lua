return {
	{
		"mason-org/mason.nvim",
		opts = {
		},
		config = function()
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				}
			})

			local mr = require("mason-registry")

			-- Ensure Roslyn is installed
			if not mr.is_installed("roslyn") then
				mr.get_package("roslyn"):install()
			end


			-- Ensure netcoredbg is installed
			if not mr.is_installed("netcoredbg") then
				mr.get_package("netcoredbg"):install()
			end
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "ts_ls", "html", "cssls", "powershell_es" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	}
}
