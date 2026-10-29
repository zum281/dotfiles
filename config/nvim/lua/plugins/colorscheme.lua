require("gruber-darker-renaissance").setup({
	on_highlights = function(hl, c)
		hl.String = { fg = c.quartz, italic = true }
		hl.StatusLine = { fg = c.fg1, bg = c.black }
		hl.StatusLineNC = { fg = c.gray, bg = c.black }
		hl.WilderDefault = { fg = c.fg, bg = c.black }
		hl.WilderAccent = { italic = true }
		hl.WilderSelected = { fg = c.yellow, bold = true }
		hl.WilderSelectedAccent = { fg = c.black, bg = c.yellow, bold = true }
	end,
})

vim.cmd.colorscheme("gruber-darker-renaissance")
