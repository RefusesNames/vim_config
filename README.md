# Requirements

- fzf
- C-Compiler in Path
	- For Windows, see [here](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support), and maybe use
```
$vsPath = &(Join-Path ${env:ProgramFiles(x86)} "\Microsoft Visual Studio\Installer\vswhere.exe") -property installationpath
Import-Module (Join-Path $vsPath "Common7\Tools\Microsoft.VisualStudio.DevShell.dll")
Enter-VsDevShell -VsInstallPath $vsPath -SkipAutomaticLocation -DevCmdArguments '-arch=amd64 -no_logo'
```
- OmniSharp in PATH (get from [here](https://github.com/OmniSharp/omnisharp-roslyn/releases)) 

# Install TreeSitter Modules
- `:TSInstall c_sharp`
