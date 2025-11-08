return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "> ",
				selection_caret = "> ",
				layout_strategy = "vertical",
				layout_config = {},
				file_ignore_patterns = {
					"node_modules",
					".git/",
					".next/",
					"build/",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
