return {
	"quolpr/quicktest.nvim",
	config = function()
		local qt = require("quicktest")
		local playwright = require("quicktest.adapters.playwright")
		local vitest = require("quicktest.adapters.vitest")
		qt.setup({
			-- Choose your adapter, here all supported adapters are listed
			adapters = {
				vitest({
					is_enabled = function(bufnr)
						return vitest.imports_from_vitest(bufnr)
					end,
				}),
				playwright({
					is_enabled = function(bufnr)
						return playwright.imports_from_playwright(bufnr)
					end,
				}),
			},
			default_win_mode = "popup",
			use_builtin_colorizer = true,
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}
