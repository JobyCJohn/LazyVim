local opt = vim.opt

if vim.fn.has("unnamedplus") == 1 then
  opt.clipboard = { "unnamed", "unnamedplus" }
else
  opt.clipboard = "unnamed"
end

opt.autoindent = true
opt.cmdheight = 2
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
opt.path:append({ "**" }) -- finding files - Search down into subfolders
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.shiftwidth = 4
opt.shortmess:append("sI") -- don't give the intro messages when starting Vim
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
-- opt.tags = { "tags", ".git/tags" }
opt.termguicolors = true
opt.timeoutlen = 1000
opt.wildmode = "longest:full,full"

-- ignore files & folders
opt.wildignore:append("*.exe,*.dll,*.pdb,*.cache,*.resources,*.ini,*.snk,*.swp,*.swo,*.bak")
vim.g.folder_to_ignore = { "^%.git\\", "node_modules/.*" }

vim.g.autoformat = false

local utils = require('utils.utils')
if utils.is_windows == 1 and vim.fn.executable("pwsh") == 1 then
	opt.shell = "pwsh"
	opt.shellcmdflag =
		"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::UTF8"
	opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait; exit $LastExitCode"
	opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	opt.shellquote = ""
	opt.shellxquote = ""
end
