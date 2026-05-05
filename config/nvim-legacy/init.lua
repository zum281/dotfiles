if vim.g.vscode then
	require("core.opts")
	require("core.keymaps")
else
	require("core.opts")
	require("config.lazy")
	require("core.lsp")
	require("core.keymaps")
	require("core.autocmd")
	require("core.colorscheme")
end
