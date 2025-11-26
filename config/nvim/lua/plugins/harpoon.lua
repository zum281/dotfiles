return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local set = vim.keymap.set
		local harpoon = require("harpoon")

		set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "harpoon list" })
		set("n", "<C-a>", function()
			harpoon:list():add()
		end, { desc = "harpoon add file" })
		set("n", "<C-h>", function()
			harpoon:list():prev()
		end, { desc = "harpoon prev file" })
		set("n", "<C-t>", function()
			harpoon:list():next()
		end, { desc = "harpoon next file" })
	end,
}
