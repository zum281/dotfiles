return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({
			auto_open = false, -- Don't auto-open
			auto_close = true, -- Auto-close when no issues
		})
	end,
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
	},
}
