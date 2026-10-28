local toggleterm = require("toggleterm")

toggleterm.setup({
	open_mapping = [[<C-t>]],
	hide_numbers = true,
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	persist_size = true,
	persist_mode = true,
	direction = "float",
	close_on_exit = true,
	clear_env = false,

	shell = vim.o.shell,
	auto_scroll = true,

	float_opts = {

		border = "single",
		width = 80,
		height = 20,
		title_pos = "center",
	},
	winbar = {
		enabled = false,
	},
	responsiveness = {
		horizontal_breakpoint = 135,
	},
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
