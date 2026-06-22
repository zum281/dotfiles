local dap = require("dap")
local dapui = require("dapui")
local pal = require("zusk.palette")

dapui.setup({
	layouts = {
		{
			position = "left",
			size = 40,
			elements = {
				{ id = "scopes", size = 0.4 },
				{ id = "stacks", size = 0.3 },
				{ id = "watches", size = 0.15 },
				{ id = "breakpoints", size = 0.15 },
			},
		},
		{
			position = "bottom",
			size = 8,
			elements = {
				{ id = "repl", size = 1.0 },
			},
		},
	},
})

vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = pal.base02 })
vim.api.nvim_set_hl(0, "DapStoppedSign", { fg = pal.base0A, bg = pal.base02 })
vim.api.nvim_set_hl(0, "DapBreakpointSign", { fg = pal.base08 })

require("nvim-dap-virtual-text").setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,
	only_first_definition = true,
	all_references = false,
	filter_references_pattern = "<module",
	virt_text_pos = "eol",
	all_frames = false,
	virt_lines = false,
	virt_text_win_col = nil,
})

dap.defaults.codelldb.external_terminal = {
	command = "tmux",
	args = { "split-window", "-h" },
}

dap.listeners.after.event_initialized.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.c = {
	{
		type = "codelldb",
		request = "launch",
		name = "Debug Executable",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		terminal = "external",
	},
	{
		type = "codelldb",
		request = "launch",
		name = "Debug Executable (with args)",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		args = function()
			local input = vim.fn.input("Arguments: ")
			return vim.split(input, " ", { trimempty = true })
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		terminal = "external",
	},
}

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpointSign", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointSign", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointSign", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapBreakpointSign", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStoppedSign", linehl = "DapStoppedLine", numhl = "DapStoppedSign" })

local set = vim.keymap.set
set("n", "<leader>xb", function() dap.toggle_breakpoint() end, { desc = "breakpoint" })
set("n", "<leader>xc", function() dap.continue() end, { desc = "continue" })
set("n", "<leader>xi", function() dap.step_into() end, { desc = "step into" })
set("n", "<leader>xo", function() dap.step_out() end, { desc = "step out" })
set("n", "<leader>xO", function() dap.step_over() end, { desc = "step over" })
set("n", "<leader>xr", function() dap.repl.toggle() end, { desc = "repl" })
set("n", "<leader>xx", function() dap.terminate() end, { desc = "terminate" })
set("n", "<leader>xw", function() require("dap.ui.widgets").hover() end, { desc = "inspect variable" })
set("n", "<leader>xu", function() dapui.toggle() end, { desc = "toggle ui" })
