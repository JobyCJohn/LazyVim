return {
	{ "bilal2453/luvit-meta", enabled = false },
	{ "folke/flash.nvim", enabled = false },
	{ "folke/noice.nvim", enabled = false },
	{ "folke/todo-comments.nvim", enabled = false },
	{ "folke/which-key.nvim", enabled = false },
	{ "gbprod/yanky.nvim", enabled = false },
	{ "ggandor/leap.nvim", enabled = false },
	{ "lakas-reineke/indent-blankline.nvim", enabled = false },
	{ "nvimdev/dashboard-nvim", enabled = false },

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			if vim.fn.has("gui_running") == 1 then
				require("onedark").setup({
					style = "deep",
				})
			else
				require("onedark").setup({
					style = "deep",
					transparent = true,
					lualine = {
						transparent = true,
					},
				})
			end
			require("onedark").load()
		end,
	},
}
