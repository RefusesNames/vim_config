-- install prerequisites via "npm install -g typescript typescript-language-server"
require('lspconfig').ts_ls.setup{}

vim.lsp.enable('ts_ls')
