local set = vim.keymap.set

vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = "," -- comma for localleader (Conjure etc.)

-- better movement in wrapped text
set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- window / tmux pane navigation (smart-splits)
set("n", "<C-h>", function()
	require("smart-splits").move_cursor_left()
end, { desc = "Move to left split/pane" })
set("n", "<C-j>", function()
	require("smart-splits").move_cursor_down()
end, { desc = "Move to lower split/pane" })
set("n", "<C-k>", function()
	require("smart-splits").move_cursor_up()
end, { desc = "Move to upper split/pane" })
set("n", "<C-l>", function()
	require("smart-splits").move_cursor_right()
end, { desc = "Move to right split/pane" })

-- clear search highlights
set({ "n", "v" }, "<Esc><Esc>", ":nohlsearch<cr>", { desc = "clear search highlights" })

set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

set("n", "<leader>yy", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

-- gitsigns — hunk navigation and staging
set("n", "g]", function()
	require("gitsigns").next_hunk()
end, { desc = "Next hunk" })
set("n", "g[", function()
	require("gitsigns").prev_hunk()
end, { desc = "Prev hunk" })
set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
set("n", "<leader>hS", function()
	require("gitsigns").stage_buffer()
end, { desc = "Stage buffer" })
set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
set("n", "<leader>hR", function()
	require("gitsigns").reset_buffer()
end, { desc = "Reset buffer" })
set("n", "<leader>hb", function()
	require("gitsigns").blame_line()
end, { desc = "Blame line" })

-- neogit
set("n", "<leader>g", function()
	require("neogit").open()
end, { desc = "Neogit" })

-- neotest — vitest runner
--   <leader>tt   run all tests in current file
--   <leader>tr   run nearest test (under cursor)
--   <leader>ts   toggle summary panel
--   <leader>to   toggle output panel
--   <leader>tx   stop running tests
set("n", "<leader>tt", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run file tests" })
set("n", "<leader>tr", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })
set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Test summary" })
set("n", "<leader>to", function()
	require("neotest").output_panel.toggle()
end, { desc = "Test output" })
set("n", "<leader>tx", function()
	require("neotest").run.stop()
end, { desc = "Stop tests" })

--- Diagnostics
set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Diagnostic float" })
set("n", "<leader>dD", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle show/hide diagnostics" })
set("n", "<leader>dq", function()
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
-- Completion (mini.completion, triggered automatically):
--   <C-n>/<C-p>  move down/up in menu
--   <C-y>        confirm selection
--   <C-e>        dismiss menu
--   <C-Space>    manually retrigger menu
--   snippets expand on accept, no tabstop jumping
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local buf = args.buf
		-- send definitions to quickfix for multi-result navigation
		vim.keymap.set("n", "grd", function()
			vim.lsp.buf.definition({
				on_list = function(options)
					vim.fn.setqflist({}, " ", options)
					vim.cmd.copen()
				end,
			})
		end, { buffer = buf, desc = "LSP definition (quickfix)" })
		-- toggle inlay hints per buffer
		vim.keymap.set("n", "<leader>i", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
		end, { buffer = buf, desc = "Toggle inlay hints" })

		-- wire mini.completion to this buffer's LSP client
		vim.bo[buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
	end,
})

-- zusk
set("n", "<leader>z", function()
	if vim.t.zoomed then
		vim.cmd("wincmd =") -- restore equal sizes
		vim.t.zoomed = false
	else
		vim.cmd("wincmd _ | wincmd |") -- max height + width
		vim.t.zoomed = true
	end
end, { desc = "Toggle window zoom" })
