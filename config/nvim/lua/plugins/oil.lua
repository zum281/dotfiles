require("oil").setup({
	default_file_explorer = true,
	view_options = { show_hidden = true },
	columns = {
		"icon",
		{ "permissions", highlight = "Special" },
		{ "size", highlight = "Number" },
		{ "mtime", format = "%Y-%m-%d %H:%M:%S", highlight = "Comment" },
	},
})
