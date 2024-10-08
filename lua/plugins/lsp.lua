return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = {
				"gi",
				"<CMD>lua vim.lsp.buf.implementation()<CR>",
				desc = "Goto Implementation",
				mode = { "n", "v" },
			}
			keys[#keys + 1] = {
				"<F2>",
				"<CMD>lua vim.lsp.buf.rename()<CR>",
				desc = "Rename",
				mode = { "n", "v" },
			}
		end,
        opts = function(_, opts)
            opts.document_highlight.enabled = false
        end,
	},
}
