vim.g["conjure#filetypes"] = { "racket" }
vim.g["conjure#filetype#racket"] = "conjure.client.racket.stdio"
vim.g["conjure#client#racket#stdio#command"] = "racket -i"
vim.filetype.add({ extension = { rkt = "racket" } })

-- Recover a wedged Racket REPL (e.g. after an infinite loop).
-- Kills the stuck `racket -i` process, then reloads the buffer so Conjure
-- spawns a fresh client.
local function racket_kill()
	vim.fn.jobstart({ "pkill", "-9", "-f", "racket -i" })
	vim.defer_fn(function()
		vim.cmd("edit") -- respawns Conjure's stdio client for this buffer
		vim.notify("Racket REPL restarted", vim.log.levels.INFO)
	end, 200)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "racket",
	callback = function(ev)
		vim.api.nvim_buf_create_user_command(ev.buf, "RacketKill", racket_kill, {})
		vim.keymap.set("n", "<LocalLeader>rk", racket_kill, {
			buffer = ev.buf,
			desc = "Kill + restart wedged Racket REPL",
		})
	end,
})
