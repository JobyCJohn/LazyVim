-- Open help files in a right vertical split
vim.api.nvim_create_autocmd("FileType", {
  desc = "Open help window in right vertical split",
  group = vim.api.nvim_create_augroup("help_window_right", { clear = true }),
  pattern = "help",
  callback = function()
    vim.cmd.wincmd("L")
  end,
})