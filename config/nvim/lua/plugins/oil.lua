require("oil").setup({
	default_file_explorer = true,
	view_options = { show_hidden = true },
	columns = { "icon" },
})

-- open Oil on startup (replaces old mini.starter screen)
vim.api.nvim_create_autocmd("VimEnter", {
	nested = true,
	callback = function()
		if vim.fn.argc() ~= 0 or vim.o.insertmode or not vim.o.modifiable then
			return
		end

		require("oil").open()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})
