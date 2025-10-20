local wk = require("which-key")

wk.add({
	{ "<leader>d", group = "diagnostigs", nowait = true, remap = false },
	{
		"<leader>d/",
		function()
			Snacks.picker.diagnostics()
		end,
		desc = "Diagnostics",
	},
	{
		"<leader>db",
		function()
			Snacks.picker.diagnostics_buffer()
		end,
		desc = "Buffer Diagnostics",
	},
	{ "<leader>dd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
})
