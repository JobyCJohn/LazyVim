return {
	{
		"LazyVim/LazyVim",
		dependencies = {
			"navarasu/onedark.nvim",
		},
		opts = {
			colorscheme = "onedark",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.install").prefer_git = true
		end,
	},
}
