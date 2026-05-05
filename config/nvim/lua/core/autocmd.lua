local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- format on save — for TypeScript/TSX: organize imports first, then format
-- for all other filetypes: conform formats directly
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function(ev)
    local conform_opts = { bufnr = ev.buf, lsp_format = "fallback", timeout_ms = 2000 }
    local client = vim.lsp.get_clients({ name = "ts_ls", bufnr = ev.buf })[1]

    if not client then
      require("conform").format(conform_opts)
      return
    end

    local result = client:request_sync("workspace/executeCommand", {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(ev.buf) },
    })
    if result and result.err then
      vim.notify(result.err.message, vim.log.levels.ERROR)
      return
    end

    require("conform").format(conform_opts)
  end,
})



-- enable code lens when LSP attaches (shows reference counts, implementations, etc.)
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    vim.lsp.codelens.enable(true, { bufnr = ev.buf })
  end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})


-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})
