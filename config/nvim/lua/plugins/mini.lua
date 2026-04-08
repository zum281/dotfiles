return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		local p = require("core.palette")
		require("mini.icons").setup({
			style = "glyph",
		})
		vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = p.accent, bg = p.bg })
		vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { fg = p.accent, bg = p.bg })
		vim.api.nvim_set_hl(0, "MiniStatuslineGit", { fg = p.ok, bg = p.bg })
		vim.api.nvim_set_hl(0, "MiniStatuslineDim", { fg = p.fg_dim, bg = p.bg })

		require("mini.statusline").setup({
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 9999 })
					local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
					local git = MiniStatusline.section_git({ trunc_width = 40, icon = "" })
					local diff = MiniStatusline.section_diff({ trunc_width = 60 })
					local diagnostics = MiniStatusline.section_diagnostics({
						trunc_width = 75,
						icon = "",
						signs = {
							ERROR = "e",
							WARN = "w",
							INFO = "i",
							HINT = "h",
						},
					})
					local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
					local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 100 })

					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%<",
						"%=",
						{ hl = "MiniStatuslineGit", strings = { git, diff } },
						{ hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
						{ hl = "MiniStatuslineDim", strings = { lsp, fileinfo } },
					})
				end,
			},
			use_icons = true,
		})
		local ai = require("mini.ai")
		ai.setup({
			custom_textobjects = {
				F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
			},
		})
		require("mini.pairs").setup()
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

				-- text objects
				{ mode = "o", keys = "a" },
				{ mode = "o", keys = "i" },
				{ mode = "x", keys = "a" },
				{ mode = "x", keys = "i" },

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
