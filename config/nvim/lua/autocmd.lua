local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Remove trailing space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- organize imports on save
local function organize_imports(bufnr)
	local filetype = vim.bo.filetype

	if filetype:match("^javascript") or filetype:match("^typescript") then
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		local ts_client = nil

		for _, client in pairs(clients) do
			if client.name == "tsserver" or client.name == "ts_ls" or client.name == "vtsls" then
				ts_client = client
				break
			end
		end

		if ts_client then
			local params = {
				command = "_typescript.organize_imports",
				arguments = { vim.api.nvim_buf_get_name(bufnr) },
			}
			local success = vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, 1000)
			if not success then
				vim.lsp.bug.code_action({
					bufnr = bufnr,
					context = {
						only = { "source.organizeImports" },
						apply = true,
						timeout = 500,
					},
				})
			end
		end
	end
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
	group = vim.api.nvim_create_augroup("TSSaveActions", { clear = true }),
	callback = function(args)
		organize_imports(args.buf)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*", "!*.ts", "!*.tsx", "!*.js", "!*.jsx" },
	group = vim.api.nvim_create_augroup("GeneralFormatOnSave", { clear = true }),
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
