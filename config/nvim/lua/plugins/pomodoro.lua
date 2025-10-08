return {
	"quentingruber/pomodoro.nvim",
	lazy = false,
	opts = {
		start_at_launch = false,
		work_duration = 25,
		break_duration = 5,
		delay_duration = 1, -- The additionnal work time you get when you delay a break
		long_break_duration = 15,
		breaks_before_long = 4,
		display_ui_on_break = false, -- Disable it if you only want to see the lualine
	},
	keys = {
		{
			---For which key usage
			"<leader>pp",
			"<cmd>PomodoroUI<cr>",
			desc = "pomodoro",
		},
	},
}
