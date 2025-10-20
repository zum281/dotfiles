local wk = require("which-key")

wk.add({
	{
		"<leader>o",

		function()
			Snacks.picker.todo_comments()
		end,
		desc = "todo",
	},
})
