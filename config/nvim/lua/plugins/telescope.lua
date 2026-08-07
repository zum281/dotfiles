require("telescope").setup({
	defaults = {
		preview = true,
		layout_strategy = "vertical",
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		mappings = {
			i = { ["<esc>"] = require("telescope.actions").close },
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep" })
vim.keymap.set("n", "<leader>.", builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>,", builtin.jumplist, { desc = "Jumplist" })
vim.keymap.set("n", "<leader>;", builtin.quickfix, { desc = "Quickfix" })
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Old files" })
vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "Spell suggest" })
vim.keymap.set("n", "q/", builtin.search_history, { desc = "Search history" })
vim.keymap.set("n", "q:", builtin.command_history, { desc = "Command history" })
