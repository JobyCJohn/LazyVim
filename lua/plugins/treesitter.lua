return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "c", "cpp", "c_sharp", "lua", "luap" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        opts = function(_, opts)
            opts.move.keys.goto_next_start["]c"] = nil
            opts.move.keys.goto_previous_start["[c"] = nil
        end,
    },
}
