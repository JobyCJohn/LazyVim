return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		opts = function(_, opts)
			opts.defaults = {
				initial_mode = "normal",
				layout_config = { prompt_position = "top" },
				path_display = { "smart" },
				sorting_strategy = "ascending",
				wrap_results = true,
				file_ignore_patterns = {
					"node_modules",
					".git/*",
					"%.zip",
					"%.exe",
					"%.dll",
					"%.pdb",
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--trim",
				},
			}
			opts.mappings = {
				i = {
					["<Esc>"] = require("telescope").close,
					["<C-n>"] = require("telescope.actions").move_selection_next,
					["<C-p>"] = require("telescope.actions").move_selection_previous,
					["<C-j>"] = require("telescope.actions").cycle_history_next,
					["<C-k>"] = require("telescope.actions").cycle_history_prev,
				},
			}
			opts.pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden" },
				},
			}
			opts.extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
							["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({
								postfix = " --iglob ",
							}),
							-- freeze the current list and start a fuzzy search in the frozen list
							["<C-space>"] = require("telescope").to_fuzzy_refine,
						},
					},
				},
			}
		end,
		keys = {
			{ "<leader>fp", "<CMD>Telescope project<CR>", desc = "Projects" },

			-- grep
			{
				"<leader>fg",
				":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
				noremap = true,
				silent = true,
				desc = "Grep",
			},
			{
				"<leader>f<leader>g",
				"<cmd>Telescope dir live_grep<CR>",
				noremap = true,
				silent = true,
				desc = "Grep in sub-directory",
			},

			-- find current word
			{
				"<leader>fw",
				":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>",
				noremap = true,
				silent = true,
				desc = "Find current word in project",
			},
			{
				"<leader>fW",
				":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor_current_buffer()<CR>",
				noremap = true,
				silent = true,
				desc = "Find current word in the current buffer",
			},

			-- find visual selection
			{
				"<leader>fv",
				":lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<CR>",
				noremap = true,
				silent = true,
				desc = "Find visual selection in project",
				mode = "v",
			},
			{
				"<leader>fV",
				":lua require('telescope-live-grep-args.shortcuts').grep_visual_selection_current_buffer()<CR>",
				noremap = true,
				silent = true,
				desc = "Find visual selection in the current buffer",
				mode = "v",
			},

			-- find files
			{
				"<leader>ff",
				":lua require('utils.telescope-config').project_files()<CR>",
				desc = "Project files",
			},
			{
				"<leader>f<leader>f",
				":Telescope dir find_files<CR>",
				noremap = true,
				silent = true,
				desc = "Find files in sub-directory",
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")
			require("telescope").load_extension("project")
		end,
	},
}
