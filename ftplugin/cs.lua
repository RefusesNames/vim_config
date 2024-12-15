-- Set makeprg to 'dotnet build'
vim.opt.makeprg = 'dotnet build --no-incremental /clp:nosummary'

-- example: D:\Projekte\csharp\timetracking\CliFrontend\Program.cs(22,1): warning CS0164: This label has not been referenced [D:\Projekte\csharp\timetracking\CliFrontend\CliFrontend.csproj]
-- Set errorformat to match the output of 'dotnet build'
vim.opt.errorformat = '%f(%l\\,%c):\\ %t%*[^:]:%m,%-G%.%#'
