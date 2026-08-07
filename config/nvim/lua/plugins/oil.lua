require("oil").setup({
	default_file_explorer = true,
	view_options = { show_hidden = true },
	columns = { "icon", "permissions", "size" },
})

require("oil-lsp-diagnostics").setup({
	count = true,
	parent_dirs = true,
	diagnostic_colors = {
		error = "DiagnosticError",
		warn = "DiagnosticWarn",
		info = "DiagnosticInfo",
		hint = "DiagnosticHint",
	},
	diagnostic_symbols = {
		error = "",
		warn = "",
		info = "",
		hint = "󰌶",
	},
})

local pal = require("zusk.palette")
require("oil-git").setup({

	highlights = {
		OilGitAdded = { fg = pal.base0B },
		OilGitModified = { fg = pal.base0A },
		OilGitRenamed = { fg = pal.base0E },
		OilGitUntracked = { fg = pal.base0D },
		OilGitIgnored = { fg = pal.base04 },
	},
})
