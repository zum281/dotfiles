local pal = require("zusk.palette")

vim.api.nvim_set_hl(0, "StatusLine", { bg = pal.base00, fg = pal.base05 })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = pal.base00, fg = pal.base03 })

-- mode code -> { label, color }
local modes = {
	n = { "N", pal.base0A },
	no = { "N", pal.base0A },
	nov = { "N", pal.base0A },
	noV = { "N", pal.base0A },
	["no\22"] = { "N", pal.base0A },
	niI = { "N", pal.base0A },
	niR = { "N", pal.base0A },
	niV = { "N", pal.base0A },
	nt = { "N", pal.base0A },
	ntT = { "N", pal.base0A },
	v = { "V", pal.base0E },
	vs = { "V", pal.base0E },
	V = { "V-L", pal.base0E },
	Vs = { "V-L", pal.base0E },
	["\22"] = { "V-B", pal.base0E },
	["\22s"] = { "V-B", pal.base0E },
	s = { "S", pal.base0D },
	S = { "S-L", pal.base0D },
	["\19"] = { "S-B", pal.base0D },
	i = { "I", pal.base0B },
	ic = { "I", pal.base0B },
	ix = { "I", pal.base0B },
	R = { "R", pal.base08 },
	Rc = { "R", pal.base08 },
	Rx = { "R", pal.base08 },
	Rv = { "V-R", pal.base08 },
	Rvc = { "V-R", pal.base08 },
	Rvx = { "V-R", pal.base08 },
	c = { "C", pal.base09 },
	cv = { "EX", pal.base09 },
	ce = { "EX", pal.base09 },
	r = { "P", pal.base09 },
	rm = { "M", pal.base09 },
	["r?"] = { "?", pal.base09 },
	["!"] = { "!", pal.base0C },
	t = { "T", pal.base0C },
}

-- pre-create one highlight group per distinct mode color (black text on color)
for _, m in pairs(modes) do
	local group = "ZuskMode" .. m[2]:gsub("#", "")
	vim.api.nvim_set_hl(0, group, { bg = m[2], fg = pal.base00, bold = true })
	m[3] = group
end

local diagnostics = {
	{ vim.diagnostic.severity.ERROR, "\u{ea87}", pal.base08 },
	{ vim.diagnostic.severity.WARN, "\u{ea6c}", pal.base09 },
	{ vim.diagnostic.severity.HINT, "\u{ea61}", pal.base0D },
}

for _, d in ipairs(diagnostics) do
	local group = "ZuskSLDiag" .. d[1]
	vim.api.nvim_set_hl(0, group, { bg = pal.base00, fg = d[3] })
	d[4] = group
end

local function esc(s)
	return (s:gsub("%%", "%%%%"))
end

local function section_mode()
	local code = vim.api.nvim_get_mode().mode
	local m = modes[code] or modes[code:sub(1, 1)] or { "?", pal.base05, "StatusLine" }
	return m[3], m[1]
end

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

local function section_git()
	local head = vim.b.gitsigns_head
	if not head or head == "" then
		return ""
	end
	return esc(head)
end

local function section_diagnostics()
	local counts = vim.diagnostic.count(0)
	local parts = {}
	for _, d in ipairs(diagnostics) do
		local n = counts[d[1]] or 0
		if n > 0 then
			parts[#parts + 1] = ("%%#%s#%s%d"):format(d[4], d[2], n)
		end
	end
	return table.concat(parts, " ")
end

local function section_filetype()
	local ft = vim.bo.filetype
	if ft == "" then
		return ""
	end
	local icon = require("mini.icons").get("filetype", ft)
	return icon .. " " .. ft
end

function _G.ZuskStatusline()
	local mhl, mlabel = section_mode()
	local git = section_git()
	local diag = section_diagnostics()
	local ft = section_filetype()

	local left = ("%%#%s# %s %%#StatusLine# %s%%m%%r"):format(mhl, mlabel, esc(filepath()))
	if git ~= "" then
		left = left .. "   " .. git
	end

	local right = ""
	if diag ~= "" then
		right = right .. diag .. "  "
	end
	right = right .. ("%%#StatusLine#%s  %%#%s# %%l:%%c "):format(ft, mhl)

	return left .. "%=" .. right
end

vim.o.statusline = "%!v:lua.ZuskStatusline()"
