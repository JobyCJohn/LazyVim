local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

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

-- paste after/before the current line
map("n", "]p", "m`o<ESC>p``")
map("n", "[p", "m`O<ESC>p``")

-- visual mode "P" never yank the pasted over text into the register
map("x", "p", "P")

-- tab
map("n", "<Leader>tn", "<Cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<Leader>tc", "<Cmd>tabclose<CR>", { desc = "Close Tab" })
