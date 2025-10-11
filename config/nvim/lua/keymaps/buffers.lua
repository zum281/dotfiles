local wk = require("which-key")

wk.add({
	{ "<leader>b", group = "buffers", nowait = true, remap = false },
	{
		"<leader>bd",
		function()
			Snacks.bufdelete()
		end,
		desc = "Delete Buffer",
	},
	{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "delete buffers right" },
	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "delete buffers left" },
	{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "previous buffer" },
	{ "<S-t>", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer" },
	{ "b[", "<cmd>BufferLineCyclePrev<cr>", desc = "previous buffer" },
	{ "b]", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer" },
	{ "b(", "<cmd>BufferLineMovePrev<cr>", desc = "move buffer left" },
	{ "b)", "<cmd>BufferLineMoveNext<cr>", desc = "move buffer right" },
	{
		"<leader>bR",
		function()
			Snacks.rename.rename_file()
		end,
		desc = "Rename buffer",
	},
})
