local set = vim.keymap.set

-- Center screen when jumping
set("n", "n", "nzzzv", { desc = "next search result" })
set("n", "N", "Nzzzv", { desc = "previous search result" })
set("n", "<C-d>", "<C-d>zz", { desc = "half page down" })
set("n", "<C-u>", "<C-u>zz", { desc = "half page up" })

-- clear search highlights
set({ "n", "v" }, "<Esc><Esc>", ":nohlsearch<cr>", { desc = "clear search highlights" })

-- buffers
set({ "n", "v" }, "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "delete buffer" })
set({ "n", "v" }, "<leader>bx", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end, { desc = "delete all buffers except current" })

-- window navigation (smart-splits)
set("n", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "window left" })
set("n", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "window right" })
set("n", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "window up" })
set("n", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "window down" })

-- explorer
set("n", "-", "<cmd>Oil<cr>", { desc = "oil" })

-- picker
set("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "find files" })
set("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "live grep" })
set("n", "<leader>b", function()
	Snacks.picker.buffers()
end, { desc = "buffers" })
set("n", "<leader>m", function()
	Snacks.picker.man()
end, { desc = "man pages" })
set("n", "<leader>fk", function()
	Snacks.picker.keymaps()
end, { desc = "keymaps" })
set("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "help" })
set("n", "<leader>fc", function()
	Snacks.picker.commands()
end, { desc = "commands" })

-- git
set("n", "gb", function()
	Snacks.git.blame_line()
end, { desc = "git blame" })
set("n", "<leader>G", function()
	Snacks.lazygit()
end, { desc = "lazygit" })
set("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "git status" })
set("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { desc = "git log" })
set("n", "<leader>gb", function()
	Snacks.picker.git_branches()
end, { desc = "git branches" })
set("n", "<leader>gd", function()
	Snacks.picker.git_diff()
end, { desc = "git diff" })

-- gitsigns
set("n", "g]", function()
	require("gitsigns").next_hunk()
end, { desc = "next hunk" })
set("n", "g[", function()
	require("gitsigns").prev_hunk()
end, { desc = "prev hunk" })
set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "stage hunk" })
set("n", "<leader>hS", function()
	require("gitsigns").stage_buffer()
end, { desc = "stage buffer" })
set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "reset hunk" })
set("n", "<leader>hR", function()
	require("gitsigns").reset_buffer()
end, { desc = "reset buffer" })
set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "preview hunk" })
set("n", "<leader>gg", function()
	require("gitsigns").setqflist("all")
	vim.cmd("copen")
end, { desc = "changed files" })

-- scratch
set("n", "<leader>s", function()
	Snacks.scratch.select()
end, { desc = "scratch buffer select" })
set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "scratch buffer toggle" })

-- todos
set("n", "<leader>xt", "<cmd>TodoQuickFix<cr>", { desc = "todos" })

set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "previous buffer" })
set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next buffer" })

-- diagnostics
set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "line diagnostics" })

-- yank
set("n", "<leader>ya", ":keepjumps normal! ggyG<cr>", { desc = "yank all" })
set("n", "<leader>yy", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "yank path" })
