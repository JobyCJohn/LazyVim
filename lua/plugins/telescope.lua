return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        opts = function(_, opts)
            opts.defaults = {
                file_ignore_patterns = vim.g.folder_to_ignore,
                initial_mode = "normal",
                layout_config = { prompt_position = "top" },
                mappings = {
                    i = {
                        ["<Esc>"] = require("telescope.actions").close,
                        ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
                        ['<C-j>'] = require("telescope.actions").move_selection_next,
                        ['<C-k>'] = require("telescope.actions").move_selection_previous,
                        ['<CR>'] = require('utils.utils').multiopen
                    },
                    n = {
                        ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
                        ['<CR>'] = require('utils.utils').multiopen
                    }
                },
                path_display = { "smart" },
                preview = { hide_on_startup = true },
                sorting_strategy = "ascending",
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim",
                },
                wrap_results = true,
            }
            opts.pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden" },
                },
            }
            opts.extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                            ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({
                                postfix = " --iglob ",
                            }),
                            -- freeze the current list and start a fuzzy search in the frozen list
                            ["<C-space>"] = require("telescope").to_fuzzy_refine,
                        },
                    },
                },
            }
        end,
        keys = {
            -- projects
            { "<leader>fp",
                "<CMD>Telescope project<CR>",
                silent = true,
                desc = "Projects" },
            -- grep
            { "<leader>fg",
                ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
                silent = true,
                desc = "Grep" },
            -- find files
            {
                "<leader>ff",
                ":lua require('utils.utils').project_files()<cr>",
                silent = true,
                desc = "Find Files (Root Dir)",
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension("project")
        end,
    },
}
