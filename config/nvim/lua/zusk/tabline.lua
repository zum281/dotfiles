local pal = require("zusk.palette")

vim.api.nvim_set_hl(0, "TabLineSel", { fg = pal.base0A, bg = pal.base00 })
vim.api.nvim_set_hl(0, "TabLine", { fg = pal.base03, bg = pal.base00 })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = pal.base00 })

function _G.ZuskTabline()
	local cur = vim.api.nvim_get_current_tabpage()
	local parts = {}

	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		local hl = (tab == cur) and "TabLineSel" or "TabLine"
		local win = vim.api.nvim_tabpage_get_win(tab)
		local buf = vim.api.nvim_win_get_buf(win)
		local path = vim.api.nvim_buf_get_name(buf)
		local name = path == "" and "[No Name]" or vim.fn.fnamemodify(path, ":t")
		parts[#parts + 1] = string.format("%%#%s# %s ", hl, name:upper())
	end
	parts[#parts + 1] = "%#TabLineFill#"
	return table.concat(parts)
end

vim.o.tabline = "%!v:lua.ZuskTabline()"
