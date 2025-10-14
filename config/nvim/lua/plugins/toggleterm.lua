return {
	{
		"akinsho/toggleterm.nvim",
		version = "*", -- use tag 'v2.*' for Neovim < 0.7
		config = function()
			require("toggleterm").setup({
				-- Your configuration options go here
				size = 20,
				open_mapping = [[<C-\>]], -- The key to use for toggling the terminal
				direction = "float", -- horizontal, vertical, or float
				terminal_mappings = true, -- allow mappings when terminal is open
				close_on_exit = false,
				float_opts = {
					border = "curved",
					winblend = 3,
					-- Define dimensions as a percentage of the screen size (or fixed numbers).
					-- This makes the window "quite small" in the center.
					-- width = function(term)
					-- 	-- 50% width of the current window
					-- 	return math.floor(vim.api.nvim_win_get_width(term.winid) * 0.5)
					-- end,
					-- height = function(term)
					-- 	-- 30% height of the current window
					-- 	return math.floor(vim.api.nvim_win_get_height(term.winid) * 0.3)
					-- end,
					-- Position will be automatically calculated by toggleterm to center the float
				},
			})
		end,
	},
}
