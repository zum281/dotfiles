local set = vim.keymap.set
local defaults = { noremap = true, silent = true }

set("n", "<leader>qq", "<cmd>qa!<CR>", { desc = "Quit all" })
-- Copy all text in the current buffer
set("n", "<leader>aa", ":keepjumps normal! ggyG<cr>", defaults)
set("n", "<S-Up>", "yyddkP", defaults)
set("n", "<S-Down>", "yyddp", defaults)

set("n", "<leader>ca", function()
	vim.lsp.buf.code_action({ apply = true })
end, { desc = "Code actions" })

set("n", "<leader>cc", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Center screen when jumping
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Delete without yanking
set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Better window navigation
set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting in visual mode
set("v", "<", "<gv", { desc = "Indent left and reselect" })
set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Copy Full File-Path
set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)
