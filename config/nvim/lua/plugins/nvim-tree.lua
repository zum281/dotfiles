require("nvim-tree").setup({
	disable_netrw = true,
	hijack_directories = { enable = false },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file tree" })
