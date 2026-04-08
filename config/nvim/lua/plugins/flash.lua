return {
	"folke/flash.nvim",
	event = "VeryLazy",
	config = function()
		require("flash").setup({
			modes = {
				char = { enabled = true },
				search = { enabled = true },
			},
		})
		local p = require("core.palette")
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = p.bg, bg = p.accent, bold = true })
	end,
	keys = {
		{ "gs", function() require("flash").jump() end, desc = "Flash jump" },
		{ "gs", function() require("flash").jump() end, mode = "x", desc = "Flash jump" },
	},
}
