return {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
	config = function()
		-- Everforest configuration
		vim.g.everforest_background = "medium" -- hard, medium, soft
		vim.g.everforest_better_performance = 1
		vim.g.everforest_enable_italic = 1
		vim.g.everforest_disable_italic_comment = 0
		vim.g.everforest_transparent_background = 0 -- set to 1 if you want transparency

		-- Apply the colorscheme
		vim.cmd.colorscheme("everforest")
	end,
}
