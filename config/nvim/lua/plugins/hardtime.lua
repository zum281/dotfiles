return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	event = "VeryLazy",
	opts = {
		restriction_mode = "hint",
		max_count = 4,
		disabled_filetypes = {
			"oil",
			"NeogitStatus",
			"NeogitCommitMessage",
			"lazy",
			"mason",
			"dapui_scopes",
			"dapui_breakpoints",
			"dapui_stacks",
			"dapui_watches",
			"neotest-summary",
			"neotest-output",
			"help",
			"qf",
		},
	},
}
