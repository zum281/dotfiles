vim.bo.makeprg = "clang -std=c23 -pedantic -Wall -Wextra -Werror -o %:r %"

local set = vim.keymap.set
local terminal_buf = nil

-- Build: compile via :make, populate qflist on errors
local function build()
	vim.cmd("silent! update")
	vim.cmd("silent! make")
	local errors = vim.tbl_filter(function(e)
		return e.valid == 1
	end, vim.fn.getqflist())
	if #errors > 0 then
		vim.cmd("copen")
		return false
	end
	vim.cmd("cclose")
	return true
end

set("n", "<leader>m", build, { buffer = 0, desc = "make (build)" })

-- Run: build first, then execute compiled binary in a bottom split terminal
set("n", "<leader>r", function()
	if not build() then
		return
	end

	local bin = "./" .. vim.fn.expand("%:r")

	-- Close existing terminal buffer if it exists
	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
		local wins = vim.fn.win_findbuf(terminal_buf)
		for _, win in ipairs(wins) do
			vim.api.nvim_win_close(win, true)
		end
		vim.api.nvim_buf_delete(terminal_buf, { force = true })
	end

	vim.cmd("botright 15split | terminal " .. bin)
	terminal_buf = vim.api.nvim_get_current_buf()

	-- Close terminal with q or Esc
	set("n", "q", "<cmd>close<cr>", { buffer = terminal_buf })
	set("n", "<Esc>", "<cmd>close<cr>", { buffer = terminal_buf })
end, { buffer = 0, desc = "run" })
