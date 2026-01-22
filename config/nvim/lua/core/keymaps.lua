local set = vim.keymap.set

-- Center screen when jumping
set("n", "n", "nzzzv", { desc = "next search result" })
set("n", "N", "Nzzzv", { desc = "previous search result" })
set("n", "<C-j>", "<C-d>zz", { desc = "half page down" })
set("n", "<C-k>", "<C-u>zz", { desc = "half page up" })

-- jump list
set("n", "<C-a>", "<C-i>", { desc = "jump forward" })

-- quit all
set("n", "<leader>q", "<cmd>qa!<cr>", { desc = "quit all" })

-- clear search highlights
set({ "n", "v" }, "<C-x>", ":nohlsearch<cr>", { desc = "clear search highlights" })

-- split
set("n", "<leader>Sv", ":vsplit<cr>", { desc = "split vertical" })
set("n", "<leader>Sh", ":ssplit<cr>", { desc = "split horizontal" })

-- window navigation (smart-splits)
set("n", "<C-e>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "window left" })
set("n", "<C-u>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "window right" })
set("n", "<C-h>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "window up" })
set("n", "<C-t>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "window down" })

-- explorer
set("n", "-", "<cmd>Oil<cr>", { desc = "oil" })
set("n", "<leader>f", ":Ex<cr>")
set("n", "<leader>e", function()
	require("oil").open_float()
end, { desc = "oil float" })
set("n", "<Esc>", function()
	if vim.bo.filetype == "oil" then
		require("oil").close()
	end
end, { desc = "oil close float" })
set("n", "q", function()
	if vim.bo.filetype == "oil" then
		require("oil").close()
	end
end, { desc = "oil close float" })

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

-- git
set("n", "gb", function()
	Snacks.git.blame_line()
end, { desc = "git blame" })
set("n", "<leader>G", function()
	Snacks.lazygit()
end, { desc = "lazygit" })

-- neogit
set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "neogit status" })
set("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "neogit commit" })
set("n", "<leader>gp", "<cmd>Neogit pull<cr>", { desc = "neogit pull" })
set("n", "<leader>gP", "<cmd>Neogit push<cr>", { desc = "neogit push" })
set("n", "<leader>gl", "<cmd>Neogit log<cr>", { desc = "neogit log" })
set("n", "<leader>gb", "<cmd>Neogit branch<cr>", { desc = "neogit branch" })

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
set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "reset junk" })
set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "preview hunk" })
set("n", "hq", function()
	require("gitsigns").setqflist("all")
end, { desc = "changed files to quickfix" })

-- scratch
set("n", "<leader>s", function()
	Snacks.scratch.select()
end, { desc = "scratch buffer select" })
set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "scratch buffer toggle" })

-- alternate buffer
set("n", "<leader>a", "<cmd>b#<CR>", { desc = "alternate buf" })

-- quickfix list
set("n", "<leader>o", "<cmd>copen<CR>", { desc = "open quickfix" })
set("n", "<leader>O", "<cmd>cclose<CR>", { desc = "close quickfix" })
set("n", "]q", "<cmd>cnext<CR>", { desc = "next quickfix" })
set("n", "[q", "<cmd>cprev<CR>", { desc = "prev quickfix" })
set("n", "]Q", "<cmd>clast<CR>", { desc = "last quickfix" })
set("n", "[Q", "<cmd>cfirst<CR>", { desc = "first quickfix" })

-- location list (buffer-local quickfix)
set("n", "]l", "<cmd>lnext<CR>", { desc = "next loclist" })
set("n", "[l", "<cmd>lprev<CR>", { desc = "prev loclist" })

-- Run golangci-lint on current project
set("n", "gl", function()
	vim.cmd("!golangci-lint run")
end, { desc = "Go: Run golangci-lint" })

-- buffers
set({ "n", "v" }, "Bd", function()
	Snacks.bufdelete()
end, { desc = "delete buffer" })
set({ "n", "v" }, "Bx", function()
	local current = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end, { desc = "delete all buffers except current" })

set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "previous buffer" })
set("n", "<S-t>", "<cmd>bnext<cr>", { desc = "next buffer" })
set("n", "B[", "<cmd>bprevious<cr>", { desc = "previous buffer" })
set("n", "B]", "<cmd>bnext<cr>", { desc = "next buffer" })

-- diagnostics
set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "line diagnostics" })
set("n", "<leader>dq", function()
	vim.diagnostic.setqflist()
end, { desc = "diagnostics to quickfix" })
set("n", "<leader>rg", ":grep ", { desc = "grep search" })

-- yank
set("n", "<leader>yy", ":keepjumps normal! ggyG<cr>", { desc = "yank all" })
set("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "yank path" })
