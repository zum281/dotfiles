local cc = "clang"
local flags = {
	base = { "-std=c23", "-Wall", "-Wextra", "-pedantic" },
	build = { "-Werror" },
	debug = { "-g", "-O0" },
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
local terminal_buf = nil

-- :Debug — compile with symbols (-g -O0), then launch lldb in a bottom split
vim.api.nvim_buf_create_user_command(0, "Debug", function()
	vim.cmd("silent! update")
	local src = vim.fn.expand("%")
	-- separate debug build so :make's optimized binary isn't clobbered
	local dbg = vim.fn.expand("%:r") .. ".dbg"
	local compile = vim.fn.system(merge(cc, flags.base, flags.debug, "-o", dbg, src))
	if vim.v.shell_error ~= 0 then
		vim.notify(compile, vim.log.levels.ERROR)
		return
	end

	if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
		local wins = vim.fn.win_findbuf(terminal_buf)
		for _, win in ipairs(wins) do
			vim.api.nvim_win_close(win, true)
		end
		vim.api.nvim_buf_delete(terminal_buf, { force = true })
	end

	vim.cmd("botright 15split | terminal lldb ./" .. dbg)
	terminal_buf = vim.api.nvim_get_current_buf()
	vim.cmd("startinsert")
end, { desc = "compile with -g and launch lldb" })

set("n", "<leader>k", function()
	vim.cmd("Man 3 " .. vim.fn.expand("<cword>"))
end, { buffer = 0, desc = "man section 3" })
