local wezterm = require("wezterm")
local base16 = dofile(wezterm.config_dir .. "/../nvim/lua/zusk/palette.lua")

return {
	foreground = base16.base05,
	background = base16.base00,
	cursor_bg = base16.base0A,
	cursor_border = base16.base0A,
	cursor_fg = base16.base00,
	selection_fg = base16.base06,
	selection_bg = base16.base02,
	ansi = {
		base16.base00,
		base16.base08,
		base16.base0B,
		base16.base0A,
		base16.base0D,
		base16.base0E,
		base16.base0C,
		base16.base05,
	},
	brights = {
		base16.base03,
		base16.base08,
		base16.base0B,
		base16.base0A,
		base16.base0D,
		base16.base0E,
		base16.base0C,
		base16.base07,
	},
	tab_bar = {
		background = base16.base00,
		active_tab = { bg_color = base16.base00, fg_color = base16.base0A },
		inactive_tab = { bg_color = base16.base00, fg_color = base16.base05 },
		new_tab = { bg_color = base16.base00, fg_color = base16.base05 },
	},
}
