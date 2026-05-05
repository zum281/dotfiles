return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
	},
	cmd = "Neogit",
	opts = {
		kind = "split_above",
		disable_insert_on_commit = "auto",
		signs = {
			hunk = { "", "" },
			item = { "", "" },
			section = { "", "" },
		},
		integrations = { snacks = true },
		mappings = {
			status = { ["<space>"] = "Toggle", ["d"] = "Discard", ["R"] = "RefreshBuffer", ["a"] = "StageAll" },
		},
	},
}
