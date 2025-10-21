return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				ensure_installed = {
					"js-debug-adapter",
				},
				automatic_setup = true,
			})

			-- Mason installs js-debug-adapter but we need to set up the adapter types
			for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }) do
				dap.adapters[adapter] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "js-debug-adapter",
						args = { "${port}" },
					},
				}
			end

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				element_mappings = {},
				expand_lines = true,
				force_buffers = true,
				layouts = {
					{
						elements = {
							-- sidebar: main debugging info
							{ id = "scopes", size = 0.50 },
							{ id = "watches", size = 0.30 },
							{ id = "stacks", size = 0.20 },
						},
						size = 50, -- sidebar width in columns
						position = "right",
					},
				},
				controls = {
					enabled = true,
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "",
						terminate = "",
					},
				},
				floating = {
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				render = {
					max_type_length = nil,
					max_value_lines = 100,
					indent = 1,
				},
			})

			require("nvim-dap-virtual-text").setup({})

			-- Store original colorscheme
			local original_colorscheme = "moonfly"
			local debug_colorscheme = "kanagawa-paper-ink"

			-- Automatically open/close dap-ui when debugging starts/ends
			dap.listeners.after.event_initialized["dapui_config"] = function()
				-- Change colorscheme when debugging starts
				vim.cmd.colorscheme(debug_colorscheme)
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				-- Restore original colorscheme when debugging ends
				vim.cmd.colorscheme(original_colorscheme)
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				-- Restore original colorscheme when debugging ends
				vim.cmd.colorscheme(original_colorscheme)
				dapui.close()
			end

			-- Helper function to detect available browser
			local function get_browser_path()
				-- Check for Chrome
				local chrome_path = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
				if vim.fn.executable(chrome_path) == 1 then
					return chrome_path
				end

				-- Check for Brave
				local brave_path = "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
				if vim.fn.executable(brave_path) == 1 then
					return brave_path
				end

				return nil
			end

			-- Debug configurations for TypeScript/React
			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[language] = {
					-- Auto-detect browser
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Browser (Auto-detect)",
						url = "http://localhost:5173",
						webRoot = "${workspaceFolder}/src",
						runtimeExecutable = get_browser_path(),
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					-- Explicit Chrome
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Chrome",
						url = "http://localhost:5173",
						webRoot = "${workspaceFolder}/src",
						runtimeExecutable = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					-- Explicit Brave
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Brave",
						url = "http://localhost:5173",
						webRoot = "${workspaceFolder}/src",
						runtimeExecutable = "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser",
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					-- Attach to running browser
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Attach to Browser",
						port = 9222,
						webRoot = "${workspaceFolder}/src",
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
				}
			end

			-- Keymaps for debugging
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>dt", function()
				dap.terminate()
				-- Manually restore colorscheme when terminating
				vim.schedule(function()
					vim.cmd.colorscheme(original_colorscheme)
				end)
			end, { desc = "Debug: Terminate" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

			-- Optional: Keymaps for dap-ui specific functions
			vim.keymap.set("n", "<leader>de", function()
				dapui.eval()
			end, { desc = "Debug: Evaluate Expression" })
			vim.keymap.set("v", "<leader>de", function()
				dapui.eval()
			end, { desc = "Debug: Evaluate Selection" })

			-- Hover widget for inspecting variables (press q to close, or use keymap again)
			vim.keymap.set("n", "<leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Debug: Hover Variable" })

			-- Add expression to watches
			vim.keymap.set("n", "<leader>dw", function()
				vim.ui.input({ prompt = "Watch expression: " }, function(expr)
					if expr then
						require("dapui").elements.watches.add(expr)
					end
				end)
			end, { desc = "Debug: Add Watch" })
		end,
	},
}
