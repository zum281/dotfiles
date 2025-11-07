return {
	"stevearc/oil.nvim",
	opts = {
		-- Show hidden files
		view_options = {
			show_hidden = true,
		},
		-- Use same exclusions as your pickers
		skip_confirm_for_simple_edits = true,
		keymaps = {
			["<C-h>"] = false, -- Disable default, conflicts with window nav
			["<C-l>"] = false, -- Disable default
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
