local opt = vim.opt

vim.g.autoformat = false

opt.autoindent = true
opt.clipboard = "unnamedplus"
opt.colorcolumn = "120"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = false
opt.encoding = "utf-8"
opt.expandtab = true
opt.fileencoding = "utf-8"
opt.guicursor = "n:block,i-c-ci:ver25,v-ve-r-cr-sm-o:hor20"
opt.hlsearch = false
opt.ignorecase = true
opt.incsearch = true
opt.list = false
opt.mouse = "a"
opt.number = true
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.shiftwidth = 4
opt.shortmess:append("sI")
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 1000
opt.wildmode = "longest:full,full"

-- ignore files & folders
opt.wildignore:append("*.dll,*.pdb,*.cache,*.resources,*.exe,*.ini,*.snk,*.swp,*.swo,*.bak")
opt.wildignore:append("**/node_modules/**")

-- check if powershell executable is available
local pwsh_installed = vim.fn.executable("pwsh") == 1
local shell = pwsh_installed and "pwsh" or "powershell"
opt.shell = shell
opt.shellcmdflag =
	"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::UTF8"
opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait; exit $LastExitCode"
opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
opt.shellquote = ""
opt.shellxquote = ""
