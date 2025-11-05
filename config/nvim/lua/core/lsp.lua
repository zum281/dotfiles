vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"emmet_ls",
	"css_ls",
	"css_vars_ls",
	"tailwind_ls",
	"sql_ls",
	"go_ls",
})

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})
