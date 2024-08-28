return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "sindrets/diffview.nvim",
    },
    keys = {
        {"<Leader>gg", false},
        {"<Leader>gl", false},

        { "<Leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
        {
            "<leader>gl",
            function()
                local f = vim.fn.expand("%")
                require("neogit").action("log", "log_current", { "--", f })()
            end,
            desc = "Git log current file",
        },
    },
    opts = function(_, opts)
        opts.integrations = {
            telescope = true,
            diffview = true,
        }
    end,
}
