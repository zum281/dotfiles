local wk = require("which-key")

wk.add({
	{
		"<leader>t",
		group = "test",
		nowait = true,
		remap = false,
	},
	{
		"<leader>tr",
		"<cmd>lua require('neotest').run.run()<cr>",
		desc = "run nearest test",
	},
	{
		"<leader>tf",
		"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
		desc = "run current file",
	},
	{
		"<leader>ta",
		"<cmd>lua require('neotest').run.run({ suite = true })<cr>",
		desc = "run all tests",
	},
	{
		"<leader>td",
		"<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
		desc = "debug nearest test",
	},
	{
		"<leader>ts",
		"<cmd>lua require('neotest').run.stop()<cr>",
		desc = "stop test",
	},
	{
		"<leader>tn",
		"<cmd>lua require('neotest').run.attach()<cr>",
		desc = "attach to nearest test",
	},
	{
		"<leader>to",
		"<cmd>lua require('neotest').output.open()<cr>",
		desc = "show test output",
	},
	{
		"<leader>tp",
		"<cmd>lua require('neotest').output_panel.toggle()<cr>",
		desc = "toggle output panel",
	},
	{
		"<leader>tv",
		"<cmd>lua require('neotest').summary.toggle()<cr>",
		desc = "toggle summary",
	},
	{
		"<leader>tc",
		"<cmd>lua require('neotest').run.run({ suite = true, env = { CI = true } })<cr>",
		desc = "run all tests with ci",
	},
	-- vitest
	{
		"<leader>tw",
		group = "vitest",
		remap = false,
		nowait = true,
	},
	{
		"<leader>twr",
		"<cmd>lua require('neotest').run.run({ vitestCommand = 'vitest --watch' })<cr>",
		desc = "[vitest] run watch",
	},

	{
		"<leader>twf",
		"<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), vitestCommand = 'vitest --watch' })<cr>",
		desc = "[vitest] run watch file",
	},
	-- playwright
	{
		"<leader>tp",
		group = "playwright",
		remap = false,
		nowait = true,
	},
	{
		"<leader>tpr",
		function()
			require("neotest").playwright.run()
		end,
		desc = "[playwright] launch tests",
	},
	{
		"<leader>tpa",
		function()
			require("neotest").playwright.attachment()
		end,
		desc = "[playwright] launch test attachment",
	},
})
