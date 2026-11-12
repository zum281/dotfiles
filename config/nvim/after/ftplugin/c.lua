local cc = "clang"
local flags = {
	base = { "-std=c23", "-Wall", "-Wextra", "-pedantic" },
	build = { "-Werror" },
}

local function merge(...)
	local out = {}
	for _, item in ipairs({ ... }) do
		if type(item) == "table" then
			vim.list_extend(out, item)
		else
			out[#out + 1] = item
		end
	end
	return out
end

vim.bo.makeprg = table.concat(merge(cc, flags.base, flags.build, "-o", "%:r", "%"), " ")

local set = vim.keymap.set

set("n", "<leader>k", function()
	vim.cmd("Man 3 " .. vim.fn.expand("<cword>"))
end, { buffer = 0, desc = "man section 3" })
