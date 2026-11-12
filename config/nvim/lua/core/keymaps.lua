local set = vim.keymap.set

vim.g.mapleader = " " -- space for leader

-- better movement in wrapped text
set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- clear search highlights
set({ "n", "v" }, "<Esc><Esc>", ":nohlsearch<cr>", { desc = "clear search highlights" })

set("n", "<leader>yy", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

-- gitsigns — hunk navigation and staging
set("n", "]h", function()
	require("gitsigns").next_hunk()
end, { desc = "Next hunk" })
set("n", "[h", function()
	require("gitsigns").prev_hunk()
end, { desc = "Prev hunk" })
set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
set("n", "<leader>hb", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle line blame" })

-- neogit
set("n", "<leader>g", function()
	require("plugins.neogit").open()
end, { desc = "Neogit" })

-- neotest (vitest): run all tests in current file
set("n", "<leader>tt", function()
	require("plugins.neotest").ensure()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run file tests" })

--- Diagnostics
set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Diagnostic float" })
set("n", "<leader>dt", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle show/hide diagnostics" })
set("n", "<leader>db", function()
	vim.diagnostic.setqflist({ open = true })
end, { desc = "Buffer diagnostics (qf)" })

set("n", "]e", function()
	vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { desc = "Next error" })
set("n", "[e", function()
	vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR, float = true })
end, { desc = "Prev error" })

set("n", "]Q", "<cmd>cnfile<CR>", { desc = "Next file in qf" })
set("n", "[Q", "<cmd>cpfile<CR>", { desc = "Prev file in qf" })

-- LSP keymaps (only active when a server is attached)
-- LSP keymaps — active only in buffers with an attached server
-- Built-in 0.11 defaults (no config needed):
--   K            hover documentation
--   grn          rename symbol
--   gra          code action
--   grr          references
--   gri          implementation
--   <C-s>        signature help (insert mode)
-- Custom (defined below):
--   grd          go to definition → quickfix list
--   <leader>i    toggle inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf
		-- toggle inlay hints per buffer
		vim.keymap.set("n", "<leader>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
		end, { buffer = buf, desc = "Toggle inlay hints" })
	end,
})
