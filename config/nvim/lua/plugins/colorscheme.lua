return {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.moonflyCursorColor = true
		vim.g.moonflyNormalFloat = true
		vim.g.moonflyTransparent = true
		vim.g.moonflyUnderlineMatchParen = true
		vim.g.moonflyVirtualTextColor = true
		vim.g.moonflyWinSeparator = 2
		-- Apply the colorscheme
		vim.cmd.colorscheme("moonfly")
	end,
}
