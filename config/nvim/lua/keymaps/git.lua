local wk = require("which-key")

wk.add({
	{ "<leader>g", group = "git", nowait = true, remap = false },
	{
		"<leader>gg",
		function()
			Snacks.lazygit()
		end,
		desc = "Lazygit",
	},
	{
		"<leader>gb",
		function()
			vim.cmd.GitBlameToggle()
		end,
		desc = "blame",
	},
})
