return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
	},
	config = function()
		local neotest = require("neotest")
		local vitest = require("neotest-vitest")

		neotest.setup({
			adapters = {
				vitest({
					filter_dir = function(name, rel_path, root)
						return name ~= "node_modules"
					end,
				}),
			},
		})
	end,
	keys = {
		{ "<leader>t", "", desc = "+test" },
		{
			"<leader>tt",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "file",
		},
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "nearest",
		},
		{
			"<leader>tw",
			function()
				require("neotest").run.run({ jestCommand = "jest --watch" })
			end,
			desc = "watch",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "dap",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "output panel",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "output",
		},
		{
			"<leader>tx",
			function()
				require("neotest").run.stop()
			end,
			desc = "stop",
		},
	},
}
