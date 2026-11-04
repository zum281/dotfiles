require("gruber-darker-renaissance").setup({
	on_highlights = function(hl, c)
		hl.String = { fg = c.syntax.string }
		hl.StatusLine = { fg = c.fg1, bg = c.black }
		hl.StatusLineNC = { fg = c.gray, bg = c.black }
		hl.WilderDefault = { fg = c.fg, bg = c.black }
		hl.WilderAccent = { italic = true }
		hl.WilderSelected = { fg = c.yellow, bold = true }
		hl.WilderSelectedAccent = { fg = c.black, bg = c.yellow, bold = true }
		hl.ErrorMsg = { fg = c.red }
		hl.PmenuKind = { fg = c.gray }
		hl.PmenuBorder = { fg = c.gray }
		hl.OilDirHeader = { fg = c.syntax.string, bold = true }
		hl.OilPermissions = { fg = c.fg }
	end,
})

vim.cmd.colorscheme("gruber-darker-renaissance")
