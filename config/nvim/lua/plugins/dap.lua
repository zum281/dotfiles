return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		keys = {
			{ "<leader>d", "", desc = "+debug" },
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "continue",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "step out",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_over()
				end,
				desc = "step over",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "repl",
			},
			{
				"<leader>dx",
				function()
					require("dap").terminate()
				end,
				desc = "terminate",
			},
			{
				"<leader>dw",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "inspect variable",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup dap-ui
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 1.0 },
						},
						size = 40,
						position = "left",
					},
				},
			})

			-- Setup virtual text
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

			-- Auto open/close dap-ui
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Configure vscode-js-debug adapter
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "${port}" },
				},
			}

			-- Vitest configuration
			dap.configurations.typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug Vitest Tests",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "node",
					runtimeArgs = {
						"./node_modules/vitest/vitest.mjs",
						"run",
						"${file}",
					},
					smartStep = true,
					console = "integratedTerminal",
					sourceMaps = true,
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug Current Vitest Test",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "node",
					runtimeArgs = function()
						local file = vim.fn.expand("%:p")
						return {
							"./node_modules/vitest/vitest.mjs",
							"run",
							file,
						}
					end,
					smartStep = true,
					console = "integratedTerminal",
					sourceMaps = true,
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
				},
			}

			-- Also apply to JavaScript files
			dap.configurations.javascript = dap.configurations.typescript

			-- Signs for breakpoints
			vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "toggle ui",
			},
		},
	},
}
