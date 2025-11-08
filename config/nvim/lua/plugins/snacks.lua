return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		notifier = { enabled = true, timeout = 3000 },
		statuscolumn = { enabled = true },
		indent = { enabled = true },
		scroll = { enabled = true },
		animate = { enabled = true },
		words = { enabled = true },
		bufdelete = { enabled = true },
		rename = { enabled = true },
		image = { enabled = true },
		lazygit = { enabled = true },
	},
	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Keep debug helpers
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd
			end,
		})
	end,
}
