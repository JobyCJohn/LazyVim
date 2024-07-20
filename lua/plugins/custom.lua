return {
	{ "bilal2453/luvit-meta", enabled = false },
	{ "folke/flash.nvim", enabled = false },
	{ "folke/noice.nvim", enabled = false },
	{ "folke/todo-comments.nvim", enabled = false },
	{ "folke/which-key.nvim", enabled = false },
	{ "ggandor/leap.nvim", enabled = false },
	{ "nvimdev/dashboard-nvim", enabled = false },
	{ "rcarriga/nvim-notify", enabled = false },
	{ "lakas-reineke/indent-blankline.nvim", enabled = false },

	{
		"gbprod/yanky.nvim",
		enabled = false,
		keys = {},
	},

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({ style = "deep" })
			require("onedark").load()
		end,
	},
}
