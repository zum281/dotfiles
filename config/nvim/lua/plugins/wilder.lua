local wilder = require("wilder")

wilder.setup({
	modes = { ":", "/", "?" },
	next_key = "<Tab>",
	previous_key = "<S-Tab>",
})

local function is_find_arg(cmdline)
	local cmd = cmdline:match("^%s*(%a+)%s")
	return cmd ~= nil and #cmd >= 3 and ("find"):find("^" .. vim.pesc(cmd)) ~= nil
end

wilder.set_option("pipeline", {
	wilder.branch({
		wilder.check(function(_, x)
			return is_find_arg(x)
		end),
		function(_, x)
			return vim.fn.getcompletion(x, "cmdline")
		end,
		wilder.result({ replace = { "wilder#cmdline#replace" } }),
	}, wilder.cmdline_pipeline({ fuzzy = 1 }), wilder.search_pipeline()),
})

local pal = require("zusk.palette")
local hl = vim.api.nvim_set_hl
hl(0, "WilderAccent", { fg = pal.base0A, bold = true })
hl(0, "WilderSelected", { fg = pal.base00, bg = pal.base0A })
hl(0, "WilderSelectedAccent", { fg = pal.base00, bg = pal.base0A, bold = true })

wilder.set_option(
	"renderer",
	wilder.wildmenu_renderer({
		mode = "statusline",
		highlighter = wilder.basic_highlighter(),
		highlights = {
			accent = "WilderAccent",
			selected = "WilderSelected",
			selected_accent = "WilderSelectedAccent",
		},
		separator = " · ",
		left = { " ", wilder.wildmenu_spinner(), " " },
		right = { " ", wilder.wildmenu_index() },
	})
)
