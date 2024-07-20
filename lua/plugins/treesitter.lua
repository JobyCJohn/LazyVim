return {
	"nvim-treesitter/nvim-treesitter",
	opts = function(_, opts)
		require("nvim-treesitter.install").prefer_git = true

		vim.list_extend(opts.ensure_installed, {
			"c_sharp",
		})

		opts.ignore_install = { "jsonc" }
	end,
}
