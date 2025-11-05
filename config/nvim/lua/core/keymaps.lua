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

-- notifications picker
set("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notifications" })

-- todo picker
set("n", "<leader>o", function()
	Snacks.picker.todo_comments()
end, { desc = "todo" })

-- keep selection when indenting
set({ "n", "v" }, "<", "<gv", { desc = "indent left" })
set({ "n", "v" }, ">", ">gv", { desc = "indent right" })

-- Run golangci-lint on current project
vim.keymap.set("n", "gl", function()
	vim.cmd("!golangci-lint run")
end, { desc = "Go: Run golangci-lint" })

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
		desc = "Delete Buffer",
	},
	{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "delete buffers right" },
	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "delete buffers left" },
	{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "previous buffer" },
	{ "<S-t>", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer" },
	{ "<leader>b[", "<cmd>BufferLineCyclePrev<cr>", desc = "previous buffer" },
	{ "<leader>b]", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer" },
	{ "<leader>b(", "<cmd>BufferLineMovePrev<cr>", desc = "move buffer left" },
	{ "<leader>b)", "<cmd>BufferLineMoveNext<cr>", desc = "move buffer right" },
	{
		"<leader>bR",
		function()
			Snacks.rename.rename_file()
		end,
		desc = "Rename buffer",
	},

	-- diagnostics/debug

	{ "<leader>d", group = "diagnostigs", nowait = true },
	{
		"<leader>dD",
		function()
			Snacks.picker.diagnostics_buffer()
		end,
		desc = "Buffer Diagnostics",
	},
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
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>/a",
		function()
			Snacks.picker.autocmds()
		end,
		desc = "Autocmds",
	},
	{
		"<leader>/b",
		function()
			Snacks.picker.grep_buffers()
		end,
		desc = "Grep Open Buffers",
	},
	{
		"<leader>/c",
		function()
			Snacks.picker.command_history()
		end,
		desc = "Command History",
	},
	{
		"<leader>/C",
		function()
			Snacks.picker.commands()
		end,
		desc = "Commands",
	},
	{
		"<leader>/f",
		function()
			Snacks.picker.files()
		end,
		desc = "Files",
	},
	{
		"<leader>/h",
		function()
			Snacks.picker.search_history()
		end,
		desc = "Search History",
	},
	{
		"<leader>/H",
		function()
			Snacks.picker.help()
		end,
		desc = "Help Pages",
	},
	{
		"<leader>/i",
		function()
			Snacks.picker.icons()
		end,
		desc = "Icons",
	},
	{
		"<leader>/j",
		function()
			Snacks.picker.jumps()
		end,
		desc = "Jumps",
	},
	{
		"<leader>/k",
		function()
			Snacks.picker.keymaps()
		end,
		desc = "Keymaps",
	},
	{
		"<leader>/l",
		function()
			Snacks.picker.lines()
		end,
		desc = "Buffer Lines",
	},
	{
		"<leader>/m",
		function()
			Snacks.picker.marks()
		end,
		desc = "Marks",
	},
	{
		"<leader>/M",
		function()
			Snacks.picker.man()
		end,
		desc = "Man Pages",
	},
	{
		"<leader>/p",
		function()
			Snacks.picker.lazy()
		end,
		desc = "Search for Plugin Spec",
	},
	{
		"<leader>/q",
		function()
			Snacks.picker.qflist()
		end,
		desc = "Quickfix List",
	},
	{
		"<leader>/r",
		function()
			Snacks.picker.registers()
		end,
		desc = "Registers",
	},
	{
		"<leader>/R",
		function()
			Snacks.picker.resume()
		end,
		desc = "Resume",
	},
	{
		"<leader>/u",
		function()
			Snacks.picker.undo()
		end,
		desc = "Undo History",
	},
	{
		"<leader>/w",
		function()
			Snacks.picker.grep_word()
		end,
		desc = "Visual selection or word",
		mode = { "n", "x" },
	},
	{ "<leader>/x", ":nohlsearch<CR>", desc = "Clear search highlights" },

	-- lsp
	{
		"ga",
		function()
			vim.lsp.buf.code_action({ apply = true })
		end,
		desc = "Code actions",
	},
	{
		"gd",
		function()
			Snacks.picker.lsp_definitions()
		end,
		desc = "Goto Definition",
	},
	{
		"gD",
		function()
			Snacks.picker.lsp_declarations()
		end,
		desc = "Goto Declaration",
	},
	{
		"gi",
		function()
			Snacks.picker.lsp_implementations()
		end,
		desc = "Goto Implementation",
	},
	{
		"gr",
		function()
			Snacks.picker.lsp_references()
		end,
		nowait = true,
		desc = "References",
	},
	{
		"gs",
		function()
			Snacks.picker.lsp_symbols()
		end,
		desc = "LSP Symbols",
	},
	{
		"gw",
		function()
			Snacks.picker.lsp_workspace_symbols()
		end,
		desc = "LSP Workspace Symbols",
	},
	{
		"gy",
		function()
			Snacks.picker.lsp_type_definitions()
		end,
		desc = "Goto T[y]pe Definition",
	},

	-- tests
	{
		"<leader>t",
		group = "test",
		remap = false,
		nowait = true,
	},
	{
		"<leader>tt",
		function()
			local qt = require("quicktest")

			qt.run_all()
		end,
		desc = "run all",
	},
	{
		"<leader>tx",
		function()
			local qt = require("quicktest")

			qt.cancel_current_run()
		end,
		desc = "cancel current run",
	},

	-- splits
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
		function()
			Snacks.picker.colorschemes()
		end,
		desc = "colorschemes",
	},
})
