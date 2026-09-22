local M = {}
local loaded = false
function M.ensure()
	if loaded then
		return
	end
	loaded = true

	vim.cmd.packadd("diffview.nvim")

	require("diffview").setup({
		keymaps = {
			view = {
				{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
			},
			file_panel = {
				{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
			},
			file_history_panel = {
				{ "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
			},
		},
	})
end

return M
