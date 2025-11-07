local set = vim.keymap.set
local wk = require("which-key")

-- Center screen when jumping
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better window navigation
set("n", "<C-Left>", "<C-w>h", { desc = "Move to left window" })
set("n", "<C-Down>", "<C-w>j", { desc = "Move to bottom window" })
set("n", "<C-Up>", "<C-w>k", { desc = "Move to top window" })
set("n", "<C-Right>", "<C-w>l", { desc = "Move to right window" })

-- leap
set({ "n", "x", "o" }, "s", "<Plug>(leap)")
set("n", "S", "<Plug>(leap-from-window)")

-- quit all
set("n", "<leader>q", "<cmd>qa!<CR>", { desc = "quit all" })

-- move lines
set("n", "<S-Up>", "yyddkP", { desc = "move line up" })
set("n", "<S-Down>", "yyddp", { desc = "move line down" })

-- delete without yanking
set({ "n", "v" }, "<leader>D", '"_d', { desc = "delete without yanking" })

set({ "n", "v" }, "<", "<gv", { desc = "indent left" })
set({ "n", "v" }, ">", ">gv", { desc = "indent right" })

-- Run golangci-lint on current project
vim.keymap.set("n", "gl", function()
	vim.cmd("!golangci-lint run")
end, { desc = "Go: Run golangci-lint" })

set("n", "<leader><space>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
set("n", "<leader>,", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File explorer" })

set("n", "<leader>n", function()
	Snacks.notifier.show_history()
end, { desc = "Notification history" })

wk.add({
	-- ai
	{ "<leader>a", group = "ai", remap = false, nowait = true },
	{ "<leader>ai", "<cmd>AvanteToggle<cr>", desc = "toggle chat" },
	{ "<leader>as", "<cmd>AvanteStop<cr>", desc = "stop" },
	{ "<leader>ah", "<cmd>AvanteHistory<cr>", desc = "history" },
	{ "<leader>am", "<cmd>AvanteShowRepoMap<cr>", desc = "show repo map" },

	-- buffers
	{ "<leader>b", group = "buffers", nowait = true, remap = false },
	{
		"<leader>bd",
		function()
			Snacks.bufdelete()
		end,
		desc = "Delete buffer",
	},
	{
		"<leader>bx",
		function()
			local current = vim.api.nvim_get_current_buf()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
					vim.api.nvim_buf_delete(buf, {})
				end
			end
		end,
		desc = "Close all other buffers",
	},
	{ "<S-h>", "<cmd>bprevious<cr>", desc = "Previous buffer" },
	{ "<S-t>", "<cmd>bnext<cr>", desc = "Next buffer" },
	{ "<leader>b[", "<cmd>bprevious<cr>", desc = "Previous buffer" },
	{ "<leader>b]", "<cmd>bnext<cr>", desc = "Next buffer" },

	{ "<leader>d", group = "diagnostics", nowait = true },
	{ "<leader>dd", vim.diagnostic.open_float, desc = "Line Diagnostics" },

	--git
	{ "<leader>g", group = "git", nowait = true, remap = false },
	{
		"<leader>gg",
		function()
			Snacks.lazygit()
		end,
		desc = "Lazygit",
	},
	{
		"<leader>gb",
		"<cmd>Gitsigns toggle_current_line_blame<cr>",
		desc = "blame",
	},
	-- grep

	{ "<leader>/", group = "grep", nowait = true, remap = true },
	{
		"<leader>//",
		"<cmd>Telescope live_grep<cr>",
		desc = "Live grep",
	},
	{
		"<leader>/b",
		function()
			require("telescope.builtin").live_grep({
				grep_open_files = true,
			})
		end,
		desc = "Grep open buffers",
	},
	{
		"<leader>/f",
		"<cmd>Telescope find_files<cr>",
		desc = "Find files",
	},
	{
		"<leader>/w",
		"<cmd>Telescope grep_string<cr>",
		desc = "Grep word under cursor",
	},
	{
		"<leader>/c",
		"<cmd>Telescope command_history<cr>",
		desc = "Command history",
	},
	{
		"<leader>/C",
		"<cmd>Telescope commands<cr>",
		desc = "Commands",
	},
	{
		"<leader>/h",
		"<cmd>Telescope search_history<cr>",
		desc = "Search history",
	},
	{
		"<leader>/H",
		"<cmd>Telescope help_tags<cr>",
		desc = "Help pages",
	},
	{
		"<leader>/j",
		"<cmd>Telescope jumplist<cr>",
		desc = "Jumplist",
	},
	{
		"<leader>/k",
		"<cmd>Telescope keymaps<cr>",
		desc = "Keymaps",
	},
	{
		"<leader>/l",
		"<cmd>Telescope current_buffer_fuzzy_find<cr>",
		desc = "Buffer lines",
	},
	{
		"<leader>/m",
		"<cmd>Telescope marks<cr>",
		desc = "Marks",
	},
	{
		"<leader>/M",
		"<cmd>Telescope man_pages<cr>",
		desc = "Man pages",
	},
	{
		"<leader>/q",
		"<cmd>Telescope quickfix<cr>",
		desc = "Quickfix list",
	},
	{
		"<leader>/r",
		"<cmd>Telescope registers<cr>",
		desc = "Registers",
	},
	{
		"<leader>/R",
		"<cmd>Telescope resume<cr>",
		desc = "Resume last picker",
	},
	{ "<leader>/x", ":nohlsearch<CR>", desc = "Clear search highlights" },
	{
		"ga",
		function()
			vim.lsp.buf.code_action({ apply = true })
		end,
		desc = "Code actions",
	},
	{
		"gd",
		"<cmd>Telescope lsp_definitions<cr>",
		desc = "Goto Definition",
	},
	{
		"gi",
		"<cmd>Telescope lsp_implementations<cr>",
		desc = "Goto Implementation",
	},
	{
		"gr",
		"<cmd>Telescope lsp_references<cr>",
		desc = "References",
	},
	{
		"gy",
		"<cmd>Telescope lsp_type_definitions<cr>",
		desc = "Goto Type Definition",
	},
	{ "<leader>s", group = "split", remap = false, nowait = true },
	{ "<leader>sv", ":vsplit<CR>", desc = "Split window vertically" },
	{ "<leader>sh", ":split<CR>", desc = "Split window horizontally" },

	-- yank
	{ "<leader>y", group = "yank", remap = false, nowait = true },
	{ "<leader>yy", ":keepjumps normal! ggyG<cr>", desc = "yank all buffer content" },
	{
		"<leader>yp",
		function()
			local path = vim.fn.expand("%:p")
			vim.fn.setreg("+", path)
			print("file:", path)
		end,
		desc = "yank full file path",
	},

	-- ui
	{ "<leader>u", group = "ui", remap = false, nowait = true },
	{
		"<leader>uc",
		"<cmd>Telescope colorscheme<cr>",
		desc = "colorschemes",
	},
	{ "<leader>uw", "<cmd>set wrap!<cr>", desc = "Toggle wrap" },
})
