local wk = require("which-key")
wk.add({

	{
		"<leader>w",
		group = "warp",
		nowait = true,
		remap = false,
	},
	{
		"<leader>wm",
		group = "warp move",
		nowait = true,
		remap = false,
	},
	{
		"<leader>wa",
		"<cmd>WarpAddFile<cr>",
		desc = "warp add",
	},
	{
		"<leader>wA",
		"<cmd>WarpAddOnScreenFiles<cr>",
		desc = "warp add all on screen files",
	},
	{
		"<leader>wd",
		"<cmd>WarpDelFile<cr>",
		desc = "warp delete",
	},
	{
		"<leader>we",
		"<cmd>WarpShowList<cr>",
		desc = "warp show list",
	},
	{
		"<leader>wmt",
		"<cmd>WarpMoveTo next<cr>",
		desc = "warp move to next index",
	},
	{
		"<leader>wmh",
		"<cmd>WarpMoveTo prev<cr>",
		desc = "warp move to prev index",
	},
	{
		"<leader>wmT",
		"<cmd>WarpMoveTo last<cr>",
		desc = "warp move to the last index",
	},
	{
		"<leader>wmH",
		"<cmd>WarpMoveTo first<cr>",
		desc = "warp Move to first index",
	},
	{
		"<leader>wx",
		"<cmd>WarpClearCurrentList<cr>",
		desc = "warp clear current list",
	},
	{
		"<leader>wX",
		"<cmd>WarpClearAllList<cr>",
		desc = "warp clear all lists",
	},
	{
		"<leader>wt",
		"<cmd>WarpGoToIndex next<cr>",
		desc = "warp goto next index",
	},
	{
		"<leader>wh",
		"<cmd>WarpGoToIndex prev<cr>",
		desc = "warp goto prev index",
	},
	{
		"<leader>wH",
		"<cmd>WarpGoToIndex first<cr>",
		desc = "warp Goto first index",
	},
	{
		"<leader>wT",
		"<cmd>WarpGoToIndex last<cr>",
		desc = "warp goto last index",
	},
	{
		"<leader>w1",
		"<cmd>WarpGoToIndex 1<cr>",
		desc = "warp goto #1",
	},
	{
		"<leader>w2",
		"<cmd>WarpGoToIndex 2<cr>",
		desc = "warp goto #2",
	},
	{
		"<leader>w3",
		"<cmd>WarpGoToIndex 3<cr>",
		desc = "warp goto #3",
	},
	{
		"<leader>w4",
		"<cmd>WarpGoToIndex 4<cr>",
		desc = "warp goto #4",
	},
})
