return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.icons").setup({
			style = "glyph",
		})
		require("mini.statusline").setup({
			content = {
				active = function()
					vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#80a0ff", bg = "#000000" })
					vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = "#80a0ff", bg = "#000000" })

					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 9999 })
					local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
					local diagnostics = MiniStatusline.section_diagnostics({
						trunc_width = 75,
						icon = "<add-icon>",
						signs = {
							ERROR = "e",
							WARN = "w",
							INFO = "i",
							HINT = "h",
						},
					})

					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%<",
						"%=",
						{ hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
					})
				end,
			},
			use_icons = true,
		})
		require("mini.indentscope").setup()
		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- completions
				{ mode = "i", keys = "<C-x>" },

				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- window
				{ mode = "n", keys = "<C-w>" },

				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},
			clues = {
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
		})
	end,
}
