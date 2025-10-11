local wk = require("which-key")

wk.add({
	{ "<leader>q", "<cmd>qa!<CR>", desc = "quit all" },
	{ "<leader>y", group = "yank", remap = false, nowait = true },
	{ "<leader>yy", ":keepjumps normal! ggyG<cr>", desc = "yank all buffer content" },
	{
		"<leader>yp",
		function()
			local path = vim.fn.expand("%:p")
			vim.fn.setreg("+", path)
			print("file:", path)
		end,
		desc = "yank full file path",
	},
	{ "<S-Up>", "yyddkP", desc = "move line up" },
	{ "<S-Down>", "yyddp", desc = "move line down" },
	{ "<leader>D", "_d", desc = "delete without yanking", mode = { "n", "v" } },
	{ "<", "<gv", desc = "indent left", mode = { "n", "v" } },
	{ ">", ">gv", desc = "indent right", mode = { "n", "v" } },
})
