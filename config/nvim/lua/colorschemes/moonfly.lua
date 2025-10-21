return {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",
	lazy = false,
	priority = 1000,
	config = function()
		require("moonfly").custom_colors({
			black = "#000000",
			bg = "#000000",
			grey0 = "#4d5d8d",
			grey11 = "#000000",
			grey16 = "#080808",
		})
		vim.g.moonflyCursorColor = true
		vim.o.winborder = "single"
		vim.g.moonflyNormalFloat = true
		vim.g.moonflyTransparent = true
		vim.g.moonflyUnderlineMatchParen = true
		vim.g.moonflyVirtualTextColor = true
		vim.g.moonflyWinSeparator = 2
	end,
}
