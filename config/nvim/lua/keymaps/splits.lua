local wk = require("which-key")

wk.add({
	{ "<leader>s", group = "split", remap = false, nowait = true },
	{ "<leader>sv", ":vsplit<CR>", desc = "Split window vertically" },
	{ "<leader>sh", ":split<CR", desc = "Split window horizontally" },
})
