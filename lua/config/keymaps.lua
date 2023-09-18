_G.map = vim.api.nvim_set_keymap
_G.opts = { noremap = true, silent = true }

-- prevent x and del key overriding what's in the clipboard
map("", "x", '"_x', opts)
map("", "X", '"_x', opts)
map("", "<Del>", '"_x', opts)

-- add a line break after/before current line
map("", "]<Space>", "m`o<Esc>``", opts)
map("", "[<Space>", "m`O<Esc>``", opts)
