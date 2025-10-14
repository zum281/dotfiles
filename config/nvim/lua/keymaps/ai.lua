local wk = require("which-key")

wk.add({
	{ "<leader>a", group = "ai", remap = false, nowait = true },
	{ "<leader>ai", "<cmd>AvanteToggle<cr>", desc = "toggle chat" },
	{ "<leader>as", "<cmd>AvanteStop<cr>", desc = "stop" },
	{ "<leader>ah", "<cmd>AvanteHistory<cr>", desc = "history" },
	{ "<leader>am", "<cmd>AvanteShowRepoMap<cr>", desc = "show repo map" },
})
