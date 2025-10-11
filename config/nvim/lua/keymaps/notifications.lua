local wk = require("which-key")

wk.add({

	{ "<leader>n", group = "notifications", nowait = true, remap = false },
	{
		"<leader>nl",
		function()
			require("noice").cmd("last")
		end,
		desc = "Noice Last Message",
	},
	{
		"<leader>nh",
		function()
			require("noice").cmd("history")
		end,
		desc = "Noice History",
	},
	{
		"<leader>na",
		function()
			require("noice").cmd("all")
		end,
		desc = "Noice All",
	},
	{
		"<leader>nn",
		function()
			Snacks.picker.notifications()
		end,
		desc = "Notification History",
	},
})
