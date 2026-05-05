return {
	"kevinhwang91/nvim-hlslens",
	event = "CmdlineEnter",
	opts = {
		nearest_only = true,
	},
	config = function(_, opts)
		local p = require("core.palette")
		require("hlslens").setup(opts)
		vim.api.nvim_set_hl(0, "HlSearchLensNear", { fg = p.accent, bg = "NONE" })
	end,
}
