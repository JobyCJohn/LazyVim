if vim.g.vscode then
   return require("vscode")
end

return {
    { "catppuccin/nvim", enabled = false },
    { "folke/flash.nvim", enabled = false },
    { "folke/todo-comments.nvim", enabled = false },
    { "folke/which-key.nvim", enabled = false },
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = { enabled = false },
            indent = { enabled = false }
        }
    }
}
