local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- insert mode navigation
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })

-- add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- append bottom lines with the cursor line
map("n", "J", "mzJ`z")

-- down/up with cursor position in middle
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- next/previous search with cursor position in middle
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- add a line break after/before current line
map("n", "]<Space>", "m`o<ESC>``")
map("n", "[<Space>", "m`O<ESC>``")

-- visual mode "P" map, because it will never yank the pasted over text into the register
map("x", "p", "P")

-- floating terminal
local lazyterm = function()
	LazyVim.terminal(nil, { cwd = LazyVim.root() })
end
map("n", "<c-`>", lazyterm, { desc = "Terminal (Root Dir)" })
map("t", "<C-`>", "<CMD>close<CR>", { desc = "Hide Terminal" })
