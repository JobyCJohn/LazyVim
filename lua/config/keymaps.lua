local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
      options = vim.tbl_extend("force", options, opts)
    end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Basic movement enhancements
map("n", "J", "mzJ`z")                      -- Append lines, keep cursor
map("n", "<C-d>", "<C-d>zz")               -- Scroll down, center
map("n", "<C-u>", "<C-u>zz")               -- Scroll up, center
map("n", "n", "nzzzv")                     -- Next search result, center
map("n", "N", "Nzzzv")                     -- Previous search result, center

-- Line break insertion
map("n", "]<Space>", "m`o<ESC>``")         -- Insert line below
map("n", "[<Space>", "m`O<ESC>``")         -- Insert line above

-- Line paste helpers
map("n", "]p", "m`o<ESC>p``")              -- Paste below
map("n", "[p", "m`O<ESC>p``")              -- Paste above

-- Visual mode paste: keep register content after paste
map("x", "p", '"_dP')

-- Tab management
map("n", "<Leader>tn", "<Cmd>tabnew<CR>",   { desc = "New Tab" })
map("n", "<Leader>tc", "<Cmd>tabclose<CR>", { desc = "Close Tab" })
