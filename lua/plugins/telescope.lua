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
		keys = {
			{ "<leader>fp", "<CMD>Telescope project<CR>", desc = "Projects" },
			{
				"<leader>fg",
				":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				desc = "Projects",
			},
		},
		opts = {
			defaults = {
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
			},
			mappings = {
				i = {
					["<C-c>"] = false,
					["<Esc>"] = require("telescope.actions").close,
					["<C-n>"] = require("telescope.actions").move_selection_next,
					["<C-p>"] = require("telescope.actions").move_selection_previous,
					["<C-j>"] = require("telescope.actions").cycle_history_next,
					["<C-k>"] = require("telescope.actions").cycle_history_prev,
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden" },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
			config = function(_, opts)
				require("telescope").setup(opts)
				require("telescope").load_extension("fzf")
				require("telescope").load_extension("live_grep_args")
				require("telescope").load_extension("project")
			end,
		},
	},
}
