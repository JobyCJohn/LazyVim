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
					["<Esc>"] = require("telescope.actions").close,
				},
			},
		},
	},
	keys = {
		{ "<leader><Space>", false },
	},
}
