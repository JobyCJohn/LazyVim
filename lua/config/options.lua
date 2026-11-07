local opt = vim.opt

if vim.fn.has("clipboard") == 1 or vim.fn.has("win32") == 1 then
	opt.clipboard:append("unnamedplus")
end

opt.autoindent = true
opt.cmdheight = 2
opt.colorcolumn = "120"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.expandtab = true
opt.guicursor = "n:block,i-c-ci:ver25,v-ve-r-cr-sm-o:hor20"
opt.hlsearch = false
opt.ignorecase = true
opt.incsearch = true
opt.list = false
opt.mouse = ""
opt.number = true
opt.path:append({ "**" }) -- find files in subfolders
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 4
opt.shortmess:append("sI") -- no intro message
opt.smartcase = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 500
opt.wildmode = "longest:full,full"

-- ignore files & folders
opt.wildignore:append("*.exe,*.dll,*.pdb,*.cache,*.resources,*.ini,*.snk,*.swp,*.swo,*.bak")

vim.g.autoformat = false

local home = vim.env.HOME or vim.env.USERPROFILE
if home then
  local ripgrep_config = vim.fs.joinpath(home, "ripgreprc")
  if vim.fn.filereadable(ripgrep_config) == 1 then
    vim.env.RIPGREP_CONFIG_PATH = ripgrep_config
  end
end

-- Tree-sitter otherwise picks Strawberry Perl's 32-bit GCC on Windows.
if vim.fn.has("win32") == 1 and not vim.env.CC and vim.fn.executable("clang") == 1 then
  vim.env.CC = vim.fn.exepath("clang")
end

require("utils.utils").setup_windows_shell()
require("utils.utils").setup_windows_clipboard()