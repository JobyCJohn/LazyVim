return {
	-- Configure LazyVim to load colorscheme
	{
		"LazyVim/LazyVim",
		opts = function(_, opts)
			opts.colorscheme = "tokyonight-night"
		end,
	},
}
