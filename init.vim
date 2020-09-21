let mapleader = "\<Space>"

luafile ~/AppData/Local/nvim/lua/init.lua

if has("win64") || has("win32")
	" see ':h shell-powershell' and
	" https://github.com/junegunn/vim-plug/issues/895#issuecomment-544130552
	let &shell = has('win64') ? 'pwsh.exe': 'powershell.exe'
	set shellquote= shellpipe=\| shellxquote=
	set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
	set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif
