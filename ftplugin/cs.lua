-- Set makeprg to 'dotnet build'
vim.opt.makeprg = 'dotnet build'

-- Set errorformat to match the output of 'dotnet build'
vim.opt.errorformat = '%f(%l\\,%c):\\ %t%*[^:]:%m'
