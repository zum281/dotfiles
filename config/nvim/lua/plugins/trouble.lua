return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({
			auto_open = false, -- Don't auto-open
			auto_close = true, -- Auto-close when no issues
		})
	end,
}
