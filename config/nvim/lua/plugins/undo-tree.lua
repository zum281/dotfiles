return {
	"mbbill/undotree",
	config = function()
		vim.g.undotree_WindowLayout = 2 -- Layout style
		vim.g.undotree_ShortIndicators = 1 -- Shorter timestamps
		vim.g.undotree_SetFocusWhenToggle = 1 -- Focus tree when opened
	end,
}
