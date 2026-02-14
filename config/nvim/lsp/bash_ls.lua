return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	settings = {
		bashIde = {
			shellcheckPath = vim.fn.exepath("shellcheck"),
		},
	},
}
