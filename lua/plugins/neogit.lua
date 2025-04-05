return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        lazy = true,
        config = function()
            require("neogit").setup({
                disable_hint = true,
                disable_commit_confirmation = true,
                integrations = { diffview = true },

                status = {
                    use_floating_window = true,
                    floating_window = {
                        border = 'rounded',
                        winblend = 15,
                    },
                },
            })
        end,
        keys = {
            { "<Leader>gg", false },
            { "<Leader>gs", false },
            { "<Leader>gl", false },

            { "<Leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
            { "<Leader>gs", "<cmd>Neogit status<CR>", desc = "Git Status" },
            {
                "<Leader>gl",
                function()
                    local f = vim.fn.expand("%")
                    require("neogit").action("log", "log_current", { "--", f })()
                end,
                desc = "Git Log Current File",
            },
        },
    },

    {
        "sindrets/diffview.nvim",
        lazy = true,
        cmd = {
            "DiffviewOpen",
            "DiffviewFileHistory",
        },
        config = function()
            require('diffview').setup({
                enhanced_diff_hl = true,
                show_help_hints = false,
            })
        end,
        keys = {
            { "<Leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open Diffview" },
            { "<Leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "Git File History" },
        },
    }
}
