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

-- visual mode "P" never yank the pasted over text into the register
map("x", "p", "P")

-- neogit
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gl")

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
vim.keymap.set("n", "<leader>gl", function()
    local f = vim.fn.expand("%")
    require("neogit").action("log", "log_current", { "--", f })()
end, { desc = "Git log current file" })
