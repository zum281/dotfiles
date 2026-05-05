return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<cr>')", { silent = true, expr = true })
	end,
}
