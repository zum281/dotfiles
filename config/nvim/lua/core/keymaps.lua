local set = vim.keymap.set

-- Center screen when jumping
set("n", "n", "nzzzv", { desc = "next search result" })
set("n", "N", "Nzzzv", { desc = "previous search result" })
set("n", "<C-d>", "<C-d>zz", { desc = "half page down" })
set("n", "<C-u>", "<C-u>zz", { desc = "half page up" })

-- quit all
set("n", "<leader>q", "<cmd>qa!<cr>", { desc = "quit all" })

-- clear search highlights
set({ "n", "v" }, "<Esc><Esc>", ":nohlsearch<cr>", { desc = "clear search highlights" })

-- split
set("n", "<leader>Sv", ":vsplit<cr>", { desc = "split vertical" })
set("n", "<leader>Sh", ":ssplit<cr>", { desc = "split horizontal" })

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
	vim.cmd("Trouble quickfix")
end, { desc = "changed files to trouble" })

-- scratch
set("n", "<leader>s", function()
	Snacks.scratch.select()
end, { desc = "scratch buffer select" })
set("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "scratch buffer toggle" })

-- alternate buffer
set("n", "<leader>a", "<cmd>b#<CR>", { desc = "alternate buf" })

-- trouble
set("n", "<leader>o", "<cmd>Trouble diagnostics toggle<cr>", { desc = "diagnostics" })
set("n", "<leader>O", "<cmd>Trouble close<cr>", { desc = "close trouble" })
set("n", "]q", function()
	require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "next trouble item" })
set("n", "[q", function()
	require("trouble").prev({ skip_groups = true, jump = true })
end, { desc = "prev trouble item" })
set("n", "]Q", function()
	require("trouble").last({ skip_groups = true, jump = true })
end, { desc = "last trouble item" })
set("n", "[Q", function()
	require("trouble").first({ skip_groups = true, jump = true })
end, { desc = "first trouble item" })
set("n", "gO", "<cmd>Trouble symbols<cr>", { desc = "document symbols" })
set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "symbols" })
set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "loclist" })
set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "quickfix" })
set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "todos" })

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
set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next buffer" })

-- diagnostics
set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "line diagnostics" })
set("n", "<leader>dq", "<cmd>Trouble diagnostics toggle<cr>", { desc = "diagnostics to trouble" })

-- lsp (trouble)
set("n", "grr", "<cmd>Trouble lsp_references<cr>", { desc = "lsp references" })
set("n", "grd", "<cmd>Trouble lsp_definitions<cr>", { desc = "lsp definitions" })
set("n", "gri", "<cmd>Trouble lsp_implementations<cr>", { desc = "lsp implementations" })
set("n", "grt", "<cmd>Trouble lsp_type_definitions<cr>", { desc = "lsp type definitions" })
set("n", "<leader>rg", ":grep ", { desc = "grep search" })

-- yank
set("n", "<leader>yy", ":keepjumps normal! ggyG<cr>", { desc = "yank all" })
set("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "yank path" })
