return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				wrap_results = true,
				path_display = { "smart" },
				file_ignore_patterns = {
					"node_modules",
					".git/*",
					"%.zip",
					"%.exe",
					"%.dll",
					"%.pdb",
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
		})
		require("telescope").load_extension("fzf")
	end,
}
