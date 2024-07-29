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
			{
				"<leader>ff",
				":lua require('utils.telescope-config').project_files()<CR>",
				desc = "Project files",
			},
		},
		opts = {
			defaults = {
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
			},
			mappings = {
				i = {
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
