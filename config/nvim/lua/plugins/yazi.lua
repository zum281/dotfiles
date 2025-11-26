return {
	"mikavilpas/yazi.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"<C-y>",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "yazi current",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "yazi last",
		},
	},
	opts = {
		open_for_directories = false,
	},
}
