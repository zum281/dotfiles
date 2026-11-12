vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("PdfView", { clear = true }),
	pattern = "*.pdf",
	callback = function(ev)
		require("pdfview").open(ev.file)
	end,
})

vim.api.nvim_create_user_command("PdfOpen", function()
	require("pdfview").open()
end, { desc = "Pick a PDF and open it as text" })
vim.keymap.set("n", "<leader>jj", function()
	require("pdfview.renderer").next_page()
end, { desc = "PDF next page" })
vim.keymap.set("n", "<leader>kk", function()
	require("pdfview.renderer").previous_page()
end, { desc = "PDF previous page" })
