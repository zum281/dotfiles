return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "█" },
			change = { text = "█" },
			delete = { text = "█" },
			topdelete = { text = "█" },
			changedelete = { text = "█" },
		},
		signs_staged_enable = true,
		current_line_blame = true,
		current_line_blame_opts = { delay = 300 },
		current_line_blame_formatter = "<author> . <author_time:%d-%m-%Y %H:%M> . <summary>",
	},
}
