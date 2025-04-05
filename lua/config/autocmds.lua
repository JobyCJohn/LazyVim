-- Open help files in a right vertical split for better UX
local group = vim.api.nvim_create_augroup("help_window_right", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    desc = "Open help window in right vertical split",
    group = group,
    pattern = "help",
    callback = function()
        vim.cmd.wincmd("L")
    end,
})

-- Trim trailing whitespace on save for all modifiable buffers
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
  desc = "Trim trailing whitespace on save",
})
