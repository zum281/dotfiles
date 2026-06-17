-- mini animate
require("mini.animate").setup({})

-- mini base16
local pal = require("zusk.palette")
require("mini.base16").setup({ palette = pal })

local palette = { bg = pal.base00, fg = pal.base05, accent = pal.base0A }

-- mini.base16 colors gitsigns "change" with base0E (magenta) — reads as purple.
-- Recolor to amber so hunks follow the green/amber/red add/change/delete convention.
for _, g in ipairs({ "GitSignsChange", "GitSignsChangeLn", "GitSignsChangeInline" }) do
	vim.api.nvim_set_hl(0, g, { fg = pal.base09, bg = pal.base01 })
end

local black = palette.bg
vim.api.nvim_set_hl(0, "hl-WildMenu", { bg = black })
vim.api.nvim_set_hl(0, "SignColumn", { bg = black })
vim.api.nvim_set_hl(0, "LineNr", { bg = black })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = black })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = black })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = black })
vim.api.nvim_set_hl(0, "MiniClueNormal", { bg = black })
vim.api.nvim_set_hl(0, "MiniClueBorder", { bg = black })
vim.api.nvim_set_hl(0, "MiniClueTitle", { bg = black })

-- block cursor: gold cell, black glyph
vim.api.nvim_set_hl(0, "Cursor", { bg = palette.accent, fg = palette.bg })

-- statusline: force black bg on all groups, preserve fg from colorscheme
local function sl_hl(name)
	local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	hl.bg = 0x000000
	vim.api.nvim_set_hl(0, name, hl)
end

-- mini clue
local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		{ mode = { "n", "x" }, keys = "<Leader>" },
		{ mode = { "n", "x" }, keys = "<LocalLeader>" },
		{ mode = { "n", "x" }, keys = "g" },
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },
		{ mode = "i", keys = "<C-x>" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = { "n", "x" }, keys = "z" },
	},
	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

sl_hl("MiniClueNextKey")
sl_hl("MiniClueNextKeyWithPostkeys")
sl_hl("MiniClueDescGroup")
sl_hl("MiniClueDescSingle")
sl_hl("MiniClueSeparator")

-- mini hipatterns
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		hex_color = hipatterns.gen_highlighter.hex_color(),
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsWarn" },
		deprecated = { pattern = "%f[%w]()deprecated()%f[%W]", group = "DiagnosticWarn" },
		trail = { pattern = "%s+$", group = "Error" },
	},
})

-- mini icons
require("mini.icons").setup({})
MiniIcons.mock_nvim_web_devicons() -- redirect require("nvim-web-devicons") to mini.icons

-- mini statusline
-- Structure: [mode] [filepath] [git branch] ── [filetype] [line:col]
-- filepath: project-relative, truncated to always show full filename
require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 9999 })
			local git = MiniStatusline.section_git({ trunc_width = 40, icon = "" })
			local filetype = MiniStatusline.section_fileinfo({ trunc_width = math.huge })
			local location = MiniStatusline.section_location({ trunc_width = 9999 })

			-- project-relative path, truncated dir keeping full filename always visible
			local function filepath()
				local path = vim.api.nvim_buf_get_name(0)
				if path == "" then
					return "[No Name]"
				end
				if vim.bo.buftype ~= "" then
					return vim.fn.fnamemodify(path, ":t")
				end
				local rel = vim.fn.fnamemodify(path, ":.")
				local name = vim.fn.fnamemodify(path, ":t")
				local dir = vim.fn.fnamemodify(rel, ":h")
				if dir == "." or rel == path then
					return name
				end
				local parts = vim.split(dir, "/", { plain = true })
				if #parts > 2 then
					dir = "…/" .. parts[#parts - 1] .. "/" .. parts[#parts]
				end
				return dir .. "/" .. name
			end

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineFilename", strings = { filepath() .. "%m%r" } },
				{ hl = "MiniStatuslineDevinfo", strings = { git } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { filetype } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
	use_icons = true,
})

sl_hl("MiniStatuslineDevinfo")
sl_hl("MiniStatuslineFilename")
sl_hl("MiniStatuslineFileinfo")
sl_hl("MiniStatuslineInactive")

-- mini indentscope
require("mini.indentscope").setup({})

-- mini notify — replaces vim.notify() with floating corner notifications
require("mini.notify").setup({})

-- mini pairs — auto-closes brackets, quotes, etc. as you type
require("mini.pairs").setup({})
