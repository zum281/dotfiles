local excluded = { "node_modules", ".git", ".next", "localdb.sql", "localdb_old.sql" }
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = {
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	opts = {
		animate = { enabled = true },
		image = { enabled = true },
		bigfile = { enabled = true },
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		picker = {
			enabled = true,
			sources = {
				files = {
					hidden = true,
					ignored = true,
					exclude = excluded,
				},
				grep = {
					hidden = true,
					ignored = true,
					exclude = excluded,
				},
				explorer = {
					hidden = true,
					ignored = true,
					exclude = excluded,
				},
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		terminal = { enabled = true },
		toggle = { enabled = true },
		win = { enabled = true },
		words = { enabled = true },
		zen = { enabled = true },
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "smart",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "buffers",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "explorer",
		},
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "zen",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "zoom",
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "relative numbers" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
			end,
		})
	end,
}
