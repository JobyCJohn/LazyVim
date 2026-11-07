return {
    { "nvim-mini/mini.ai", enabled = false },
    { "folke/flash.nvim", enabled = false },
    {
        "folke/noice.nvim",
        opts = {
            cmdline = { enabled = false, },
            messages = { enabled = false, },
        },
    },
    { "folke/todo-comments.nvim", enabled = false },
    { "folke/which-key.nvim", enabled = false },
    {
        "folke/snacks.nvim",
        opts = {
            animate = { enabled = false },
            dashboard = { enabled = false },
            indent = { enabled = false }
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            opts.sections.lualine_z = {}
        end,
    },
}
