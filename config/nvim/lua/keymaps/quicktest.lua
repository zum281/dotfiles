local wk = require("which-key")
wk.add({
	{
		"<leader>t",
		group = "test",
		remap = false,
		nowait = true,
	},
	{
		"<leader>ta",
		function()
			local qt = require("quicktest")

			qt.run_all()
		end,
		desc = "run all",
	},
	{
		"<leader>td",
		function()
			local qt = require("quicktest")

			qt.run_dir()
		end,
		desc = "run dir",
	},
	{
		"<leader>tf",
		function()
			local qt = require("quicktest")

			qt.run_file()
		end,
		desc = "run file",
	},
	{
		"<leader>tl",
		function()
			local qt = require("quicktest")
			qt.run_line()
		end,
		desc = "run line",
	},
	{
		"<leader>tp",
		function()
			local qt = require("quicktest")

			qt.run_previous()
		end,
		desc = "run previous",
	},
	{
		"<leader>tt",
		function()
			local qt = require("quicktest")

			qt.toggle_win("split")
		end,
		desc = "toggle split window",
	},
	{
		"<leader>tT",
		function()
			local qt = require("quicktest")

			qt.toggle_win("popup")
		end,
		desc = "toggle split window",
	},
	{
		"<leader>tx",
		function()
			local qt = require("quicktest")

			qt.cancel_current_run()
		end,
		desc = "cancel current run",
	},
})
