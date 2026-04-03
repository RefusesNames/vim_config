vim.pack.add({
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
})

require("mason").setup({
	registries = {
		"github:mason-org/mason-registry",
		"github:Crashdummyy/mason-registry",
	}
})

local mason_registry = require("mason-registry")

-- Ensure Roslyn is installed
if not mason_registry.is_installed("roslyn") then
	mason_registry.get_package("roslyn"):install()
end


-- Ensure netcoredbg is installed
if not mason_registry.is_installed("netcoredbg") then
	mason_registry.get_package("netcoredbg"):install()
end

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "ts_ls", "html", "cssls", "powershell_es" },
})
