local actions = require("telescope.actions")
return {
	"nvim-telescope/telescope.nvim",
	opts = {
		defaults = {
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			wrap_results = true,
			path_display = { "smart" },
			mappings = {
				i = {
					["<Esc>"] = actions.close,
				},
			},
		},
	},
}
