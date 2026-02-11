vim.bo.makeprg = "clang -std=c99 -Wall -Wextra -Werror -g -fsanitize=address,undefined -o %:r %"

local set = vim.keymap.set
local terminal_buf = nil

-- Build: compile current file, populate quickfix with errors
set("n", "<leader>mb", "<cmd>make<cr>", { buffer = 0, desc = "build" })

-- Run: execute compiled binary in a bottom split terminal
set("n", "<leader>mr", function()
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
