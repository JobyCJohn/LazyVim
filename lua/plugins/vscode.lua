if not vim.g.vscode then
	return {}
end

local enabled = {
	"lazy.nvim",
	"mini.ai",
	"mini.comment",
	"mini.move",
	"mini.pairs",
	"nvim-treesitter",
	"nvim-treesitter-textobjects",
	"nvim-ts-context-commentstring",
	"vim-surround",
	"vim-repeat",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
	return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

-- vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimKeymapsDefaults",
	callback = function()
		vim.keymap.set("n", "<leader>e", [[<CMD>call VSCodeNotify('workbench.action.focusActiveEditorGroup')<CR>]])
		vim.keymap.set("n", "<leader>b", [[<CMD>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>]])
		vim.keymap.set("n", "<leader>x", [[<CMD>call VSCodeNotify('workbench.view.extensions')<CR>]])
		vim.keymap.set("n", "<leader>fe", [[<CMD>call VSCodeNotify('workbench.view.explorer')<CR>]])
		vim.keymap.set("n", "<leader>fr", [[<CMD>call VSCodeNotify('workbench.action.openRecent')<CR>]])
		vim.keymap.set("n", "<leader>ge", [[<CMD>call VSCodeNotify('workbench.scm.active')<CR>]])
		vim.keymap.set("n", "<leader>ge", [[<CMD>call VSCodeNotify('git-graph.view')<CR>]])
		vim.keymap.set("n", "<leader>fn", [[<CMD>call VSCodeNotify('welcome.showNewFileEntries')<CR>]])
		vim.keymap.set("n", "<leader>of", [[<CMD>call VSCodeNotify('revealFileInOS')<CR>]])
		vim.keymap.set("n", "<leader>oF", [[<CMD>call VSCodeNotify('workbench.action.files.openFolder')<CR>]])
		vim.keymap.set("n", "<leader>sw", [[<CMD>call VSCodeNotify('Find')<CR>]])
		vim.keymap.set("n", "<leader>sW", [[<CMD>call VSCodeNotify('workbench.action.findInFiles')<CR>]])
		vim.keymap.set("n", "<leader>ss", [[<CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>]])
		vim.keymap.set("n", "<leader>sS", [[<CMD>call VSCodeNotify('workbench.action.showAllSymbols')<CR>]])
	end,
})

return {
	{
		"LazyVim/LazyVim",
		config = function(_, opts)
			opts = opts or {}
			-- disable the colorscheme
			opts.colorscheme = function() end
			require("lazyvim").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = { enable = false },
		},
	},
}
