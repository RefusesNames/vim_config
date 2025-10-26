local local_config = require('local_config')

vim.lsp.config('powershell_es', {
	bundle_path = local_config.powershell_es_path,
})
