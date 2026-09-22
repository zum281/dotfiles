local M = {}

local loaded = false
function M.ensure()
	if loaded then
		return
	end
	loaded = true
	vim.cmd.packadd("nvim-nio")
	vim.cmd.packadd("FixCursorHold.nvim")
	vim.cmd.packadd("neotest-vitest")
	vim.cmd.packadd("neotest")

	require("neotest").setup({
		adapters = {
			require("neotest-vitest")({
				filter_dir = function(name)
					return name ~= "node_modules"
				end,
			}),
		},
	})
end

return M
