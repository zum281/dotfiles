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
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "a", desc = "new", action = ":ene | startinsert" },
					{ icon = " ", key = "r", desc = "recent", action = ":Telescope oldfiles" },
					{
						icon = " ",
						key = "g",
						desc = "git",
						action = function()
							Snacks.lazygit()
						end,
					},
					{ icon = " ", key = ".", desc = "files", action = ":Telescope find_files" },
					{ icon = " ", key = "/", desc = "grep", action = ":Telescope live_grep" },
					{ icon = " ", key = "e", desc = "oil", action = ":Oil" },
					{ icon = " ", key = "<c-y>", desc = "yazi", action = ":Yazi cwd" },
					{ icon = " ", key = "c", desc = "config", action = ":e $MYVIMRC" },
					{ icon = " ", key = "q", desc = "quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "keys", gap = 1, padding = 1 },
			},
		},
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
