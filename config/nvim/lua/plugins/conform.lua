return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			go = { "goimports" },
		},
		formatters = {
			prettier = {
				prepend_args = {
					-- "--bracket-same-line",
					"--html-whitespace-sensitivity=ignore",
				},
			},
			prettierd = {
				prepend_args = {
					-- "--bracket-same-line",
					"--html-whitespace-sensitivity=ignore",
				},
			},
		},
	},
}
