_G.map = vim.api.nvim_set_keymap
_G.opts = { noremap = true, silent = true }

-- open current file directory
map("", "<Leader>o", ":silent !start %:p:h<CR>", opts)

-- prevent x and del key overriding what's in the clipboard
map("", "x", '"_x', opts)
map("", "X", '"_x', opts)
map("", "<Del>", '"_x', opts)

-- add a line break after/before current line
map("", "]<Space>", "m`o<Esc>``", opts)
map("", "[<Space>", "m`O<Esc>``", opts)

-- delete LazyVim global key bindings
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")
