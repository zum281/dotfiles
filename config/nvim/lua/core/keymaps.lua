local set = vim.keymap.set

-- Center screen when jumping
set("n", "n", "nzzzv", { desc = "next search result" })
set("n", "N", "Nzzzv", { desc = "previous search result" })
set("n", "<C-d>", "<C-d>zz", { desc = "half page down" })
set("n", "<C-u>", "<C-u>zz", { desc = "half page up" })

-- quit all
set("n", "<leader>q", "<cmd>qa!<cr>", { desc = "quit all" })


-- clear search highlights
set({ "n", "v" }, "<C-x>", ":nohlsearch<cr>", { desc = "clear search highlights" })

-- lsp code actions
set("n", "ga", function()
  vim.lsp.buf.code_action({ apply = true })
end, { desc = "code actions" })


-- split
set("n", "<leader>Sv", ":vsplit<cr>", { desc = "split vertical" })
set("n", "<leader>Sh", ":ssplit<cr>", { desc = "split horizontal" })


-- explorer
set("n", "<leader>e", ":Ex<cr>")
set("n", "<leader>f", function() MiniFiles.open() end)

-- picker
set('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = 'find files' })
set('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'live grep' })
set('n', '<leader>b', function() Snacks.picker.buffers() end, { desc = 'buffers' })
set('n', 'gr', function() Snacks.picker.lsp_references() end, { desc = 'lsp references' })
set('n', 'gi', function() Snacks.picker.lsp_implementations() end, { desc = 'lsp implementations' })
set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'lsp definitions' })
set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = 'lsp type definitions' })
set('n', 'gli', function() Snacks.picker.lsp_incoming_calls() end, { desc = 'lsp ingoing calls' })
set('n', 'glo', function() Snacks.picker.lsp_outgoing_calls() end, { desc = 'lsp ingoing calls' })

-- git
set("n", "gb", function() Snacks.git.blame_line() end, { desc = 'git blame' })
set("n", "<leader>g", function() Snacks.lazygit() end, { desc = 'lazygit' })

-- scratch
set("n", "<leader>s", function() Snacks.scratch.select() end, { desc = 'scratch buffer select' })
set("n", "<leader>.", function() Snacks.scratch() end, { desc = 'scratch buffer toggle' })


-- Run golangci-lint on current project
set("n", "gl", function()
	vim.cmd("!golangci-lint run")
end, { desc = "Go: Run golangci-lint" })


-- buffers
set({"n", "v"}, "Bd", function() Snacks.bufdelete() end, { desc = "delete buffer" })
set({"n", "v"}, "Bx", function()
  local current = vim.api.nvim_get_current_buf()
  for _,buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, { desc = "delete all buffers except current" })

set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "previous buffer"})
set("n", "<S-t>", "<cmd>bnext<cr>", { desc = "next buffer"})
set("n", "B[", "<cmd>bprevious<cr>", { desc = "previous buffer"})
set("n", "B]", "<cmd>bnext<cr>", { desc = "next buffer"})

-- diagnostics
set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "line diagnostics" })

-- yank
set("n", "<leader>yy",":keepjumps normal! ggyG<cr>",{desc = "yank all"} )
set("n", "<leader>yp",
  function()
	  local path = vim.fn.expand("%:p")
		vim.fn.setreg("+", path)
		print("file:", path)
	end,
{desc = "yank path"} )
