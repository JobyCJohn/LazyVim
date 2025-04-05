local group = vim.api.nvim_create_augroup("help_window_right", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    desc = "Open help window in right vertical split",
    group = group,
    pattern = "help",
    callback = function()
        vim.cmd.wincmd("L")
    end,
})
