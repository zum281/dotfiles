return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = { "nvim-mini/mini.nvim" },
	opts = {
		animate = { enabled = true },
		picker = {
			enabled = true,
			layout = "ivy_split",
			sources = {
				smart = {
					multi = {
						"files",
						{ source = "help" },
					},
					transform = false,
					formatters = {
						file = { filename_first = true },
					},
				},
				keymaps = { hidden = "preview" },
				commands = { hidden = "preview" },
				git_branches = { hidden = "preview" },
			},
		},
		git = { enabled = true },
		image = { enabled = true },
		lazygit = { enabled = true },
		scratch = { enabled = true },
		scroll = { enabled = true },
		words = { enabled = true },
	},
}
