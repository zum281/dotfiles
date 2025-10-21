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
				-- Automatically configure adapters installed via Mason
				automatic_setup = true,
				handlers = {}, -- Use default handlers
			})

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

			-- Setup dap-ui with default configuration
			dapui.setup()

			-- Setup virtual text
			require("nvim-dap-virtual-text").setup({})

			-- Automatically open/close dap-ui when debugging starts/ends
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Debug configurations for TypeScript/React
			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[language] = {
					-- Debug web app in Brave
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Brave to debug client",
						url = "http://localhost:5173", -- Vite's default port
						webRoot = "${workspaceFolder}/src",
						runtimeExecutable = "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser",
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					-- Attach to an already running browser instance
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
			vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
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
		end,
	},
}
