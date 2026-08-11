local wezterm = require("wezterm")
local config = wezterm.config_builder()

local act = wezterm.action
local plug = wezterm.plugin.require

local sessionizer = plug("https://github.com/mikkasendke/sessionizer.wezterm")
local chord = plug("https://github.com/sravioli/chord.wz")
local resurrect = plug("https://github.com/StephenGemin/resurrect.wezterm")

local sessionizer_schema = {
	sessionizer.FdSearch({ wezterm.home_dir .. "/s", fd_path = "/opt/homebrew/bin/fd" }),
	{ label = "general", id = wezterm.home_dir },
	{ label = "~/notes", id = wezterm.home_dir .. "/notes" },
	{ label = "~/s/l/learn-node", id = wezterm.home_dir .. "/s/l/learn-node" },
	processing = sessionizer.for_each_entry(function(entry)
		entry.label = entry.label:gsub(wezterm.home_dir, "~")
	end),
	options = {
		title = "",
		prompt = "> ",
		always_fuzzy = true,
	},
}

chord.setup({
	command = { key = "<leader>c" },
})

resurrect.setup(config, {
	periodic_interval = 300,
	save_on_focus_loss = true,
	keybindings = false,
	status_bar = false,
})
wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

local palette = dofile(wezterm.config_dir .. "/palette.lua")
config.colors = palette

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16

config.window_close_confirmation = "NeverPrompt"

config.window_background_opacity = 0.92
config.macos_window_background_blur = 28

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

config.colors.tab_bar = { background = palette.background }

local tab_names = { "code", "gen", "ai" }

wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, max_width)
	local background = palette.background
	local foreground = palette.foreground

	if tab.is_active then
		background = "#e0b341"
		foreground = palette.background
	elseif hover then
		background = palette.selection_bg
		foreground = palette.selection_fg
	end

	local index = 1
	for i, t in ipairs(tabs) do
		if t.tab_id == tab.tab_id then
			index = i
			break
		end
	end

	local edge_foreground = background
	local name = tab_names[index] or tab.active_pane.title
	local title = " " .. index .. " " .. name .. " "

	return {
		{ Background = { Color = "none" } },
		{ Foreground = { Color = edge_foreground } },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = "none" } },
		{ Foreground = { Color = edge_foreground } },
	}
end)

config.keys = {
	{
		key = "n",
		mods = "CTRL",
		action = act.RotatePanes("Clockwise"),
	},
	{
		key = ",",
		mods = "CTRL",
		action = act.PaneSelect({ alphabet = "1234567890" }),
	},
}

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

chord.maps(config, {
	{ "<leader><Space>", sessionizer.show(sessionizer_schema), "sessionizer" },
	{ "<leader>w", act.SplitPane({ direction = "Right" }), "split horizontal" },
	{ "<leader>v", act.SplitPane({ direction = "Down" }), "split vertical" },
})

local resurrect_mode = chord.mode("resurrect_mode", {
	meta = { i = "R", txt = "RESURRECT" },
	keys = {
		{ "s", resurrect.workspace_state.save_workspace_action(), "save workspace" },
		{
			"r",
			resurrect.fuzzy_loader.restore_action({
				relative = true,
				restore_text = true,
				on_pane_restore = resurrect.pane_tree.default_on_pane_restore,
			}),
			"restore",
		},
		{ "d", resurrect.fuzzy_loader.delete_action(), "delete" },
		{ "<ESC>", "PopKeyTable", "exit" },
	},
})
chord.tables(config, { resurrect_mode })
config.keys[#config.keys + 1] = resurrect_mode:activate("<leader>s", "resurrect")

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

for key, _ in pairs(direction_keys) do
	config.keys[#config.keys + 1] = {
		key = key,
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ direction_keys[key], 5 }),
	}
end

return config
