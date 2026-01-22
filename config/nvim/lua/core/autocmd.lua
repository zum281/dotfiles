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

-- organize imports on save TYPESCRIPT
vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Format before save",
	pattern = "*",
	group = vim.api.nvim_create_augroup("FormatConfig", { clear = true }),
	callback = function(ev)
		local conform_opts = { bufnr = ev.buf, lsp_format = "fallback", timeout_ms = 2000 }
		local client = vim.lsp.get_clients({ name = "ts_ls", bufnr = ev.buf })[1]

		if not client then
			require("conform").format(conform_opts)
			return
		end

		local request_result = client:request_sync("workspace/executeCommand", {
			command = "_typescript.organizeImports",
			arguments = { vim.api.nvim_buf_get_name(ev.buf) },
		})

		if request_result and request_result.err then
			vim.notify(request_result.err.message, vim.log.levels.ERROR)
			return
		end

		require("conform").format(conform_opts)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup,
	callback = function(ev)
		local opts = { buffer = ev.buffer }
		local set = vim.keymap.set

		set("n", "gr", function()
			Snacks.picker.lsp_references()
		end, vim.tbl_extend("force", opts, { desc = "lsp references" }))

		set("n", "gi", function()
			Snacks.picker.lsp_implementations()
		end, vim.tbl_extend("force", opts, { desc = "lsp implementations" }))

		set("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, vim.tbl_extend("force", opts, { desc = "lsp definitions" }))

		set("n", "gy", function()
			Snacks.picker.lsp_type_definitions()
		end, vim.tbl_extend("force", opts, { desc = "lsp type definitions" }))

		set("n", "K", function()
			vim.lsp.buf.hover()
		end, vim.tbl_extend("force", opts, { desc = "hover" }))

		set("n", "ga", function()
			vim.lsp.buf.code_action({ apply = false })
		end, vim.tbl_extend("force", opts, { desc = "code actions" }))
	end,
})
