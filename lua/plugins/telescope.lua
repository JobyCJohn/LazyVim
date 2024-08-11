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
                initial_mode = "normal",
                layout_config = { prompt_position = "top" },
                path_display = { "smart" },
                sorting_strategy = "ascending",
                wrap_results = true,
                file_ignore_patterns = {
                    "node_modules",
                    ".git/*",
                    "%.zip",
                    "%.exe",
                    "%.dll",
                    "%.pdb",
                },
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
            }
            opts.mappings = {
                i = {
                    ["<Esc>"] = require("telescope.actions").close,
                },
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
            { "<leader>fp", "<CMD>Telescope project<CR>", desc = "Projects", }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
            require("telescope").load_extension("live_grep_args")
            require("telescope").load_extension("project")
        end,
    },
}
