return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.icons").setup({
			style = "glyph",
		})
		require("mini.statusline").setup()
	end,
}
