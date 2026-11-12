vim.g.no_plugin_maps = true

require("nvim-treesitter-textobjects").setup({
	select = { lookahead = true },
	move = { set_jumps = true },
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")
local set = vim.keymap.set

local objects = {
	f = { "@function", "function" },
	c = { "@class", "class" },
	a = { "@parameter", "parameter" },
	l = { "@loop", "loop" },
}

for key, obj in pairs(objects) do
	local capture, name = obj[1], obj[2]
	set({ "x", "o" }, "a" .. key, function()
		select.select_textobject(capture .. ".outer", "textobjects")
	end, { desc = "Around " .. name })
	set({ "x", "o" }, "i" .. key, function()
		select.select_textobject(capture .. ".inner", "textobjects")
	end, { desc = "Inside " .. name })
end

set({ "x", "o" }, "ai", function()
	select.select_textobject("@conditional.outer", "textobjects")
end, { desc = "Around conditional" })
set({ "x", "o" }, "ii", function()
	select.select_textobject("@conditional.inner", "textobjects")
end, { desc = "Inside conditional" })

local jumps = {
	f = { "@function.outer", "function" },
	k = { "@class.outer", "class" },
	a = { "@parameter.inner", "parameter" },
	o = { "@loop.outer", "loop" },
	i = { "@conditional.outer", "conditional" },
}

for key, j in pairs(jumps) do
	local capture, name = j[1], j[2]
	set({ "n", "x", "o" }, "]" .. key, function()
		move.goto_next_start(capture, "textobjects")
	end, { desc = "Next " .. name .. " start" })
	set({ "n", "x", "o" }, "[" .. key, function()
		move.goto_previous_start(capture, "textobjects")
	end, { desc = "Prev " .. name .. " start" })
	set({ "n", "x", "o" }, "]" .. key:upper(), function()
		move.goto_next_end(capture, "textobjects")
	end, { desc = "Next " .. name .. " end" })
	set({ "n", "x", "o" }, "[" .. key:upper(), function()
		move.goto_previous_end(capture, "textobjects")
	end, { desc = "Prev " .. name .. " end" })
end

set("n", "<leader>a", function()
	swap.swap_next("@parameter.inner")
end, { desc = "Swap parameter with next" })
set("n", "<leader>A", function()
	swap.swap_previous("@parameter.inner")
end, { desc = "Swap parameter with previous" })
