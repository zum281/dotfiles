local Terminal = require("toggleterm.terminal").Terminal

-- 1. npm run test
local term_test = Terminal:new({
	cmd = "npm run test",
	direction = "float",
	-- 'name' is essential for independent management
	name = "npm_test",
	hidden = true,
})
function _G.NpmTestToggle()
	term_test:toggle()
end

-- 2. npm run lint
local term_lint = Terminal:new({
	cmd = "npm run lint",
	direction = "float",
	name = "npm_lint",
	hidden = true,
})
function _G.NpmLintToggle()
	term_lint:toggle()
end

-- 3. npm run check (e.g., for type-checking or coverage)
--
local term_check = Terminal:new({
	cmd = "npm run check",
	direction = "float",
	name = "npm_check",
	hidden = true,
})
function _G.NpmCheckToggle()
	term_check:toggle()
end

local wk = require("which-key")

-- Register the keys in Normal mode
wk.register({
	o = {
		name = "terminal",
		-- Run the specific function defined above
		t = { "<cmd>lua NpmTestToggle()<CR>", "npm run test" },
		l = { "<cmd>lua NpmLintToggle()<CR>", "npm run lint" },
		c = { "<cmd>lua NpmCheckToggle()<CR>", "npm run check" },

		-- Optional: Generic terminal toggle
		f = { "<cmd>ToggleTerm direction=float<CR>", "floating terminal" },
		h = { "<cmd>ToggleTerm direction=horizontal<CR>", "horizontal terminal" },
		v = { "<cmd>ToggleTerm direction=vertical<CR>", "vertical terminal" },
	},
}, { prefix = "<leader>" })
