vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"emmet_ls",
	"tailwind_ls",
})

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})
