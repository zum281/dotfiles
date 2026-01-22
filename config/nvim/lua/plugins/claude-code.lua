return {
	"greggh/claude-code.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("claude-code").setup({
			-- Terminal window settings
			window = {
				split_ratio = 0.3, -- Percentage of screen for the terminal window
				position = "float", -- "botright", "topleft", "vertical", "float", etc.
				enter_insert = true, -- Whether to enter insert mode when opening claude code
				hide_numbers = true, -- Hide line numbers in the terminal window
				hide_signcolumn = true, -- Hide the sign column in the terminal window

				-- Floating window config (for position = "float")
				float = {
					width = "80%", -- width: number of columns or percentage string
					height = "80%", -- height: number of rows or percentage string
					row = "center", -- row position: number, "center", or percentage string
					col = "center", -- column position: number, "center", or percentage string
					relative = "editor", -- relative to: "editor" or "cursor"
					border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
				},
			},
			-- File refresh settings
			refresh = {
				enable = true, -- enable file change detection
				updatetime = 100, -- milliseconds
				timer_interval = 1000, -- milliseconds
				show_notifications = true, -- show notifications when files are reloaded
			},

			-- Git project settings
			git = {
				use_git_root = true, -- set cwd to git root when opening claude code (if in git project)
			},

			-- shell specific settings
			shell = {
				separator = "&&", -- command separator used in shell commands
				pushd_cmd = "pushd", -- command to push directory from stack
				popd_cmd = "popd", -- command to pop directory from stack
			},

			-- Command settings
			command = "claude", -- command used to launch claude code
			command_variants = {
				continue = "--continue", -- resume the most recent conversation
				resume = "--resume", -- display an interactive conversation picker
				verbose = "--verbose", -- enable verbose logging with full turn-by-turn output
			},
			-- Keymaps
			keymaps = {
				toggle = {
					normal = "<C-g>",
					terminal = "<C-g>",
					variants = {
						continue = "<leader>cC",
						verbose = "<leader>cV",
						resume = "<leader>cR",
					},
				},
				window_navigation = true,
				scrolling = true,
			},
		})
	end,
}
