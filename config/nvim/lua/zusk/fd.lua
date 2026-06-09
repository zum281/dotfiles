---Open the files picker pre-filtered with a query.
---`:fd <filename>` opens mini.pick's file picker with `<filename>`
---already typed as the prompt, so results are filtered immediately.
---@param args table Command arguments table; `args.args` holds the raw query.
local fd = function(args)
	local ok, pick = pcall(require, "mini.pick")
	if not ok then
		vim.notify("Error loading mini.pick: " .. pick, vim.log.levels.ERROR)
		return
	end

	local query = args.args
	if query ~= "" then
		-- set_picker_query only works on an active picker, and start() blocks,
		-- so seed the query from a one-shot MiniPickStart autocmd.
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniPickStart",
			once = true,
			callback = function()
				pick.set_picker_query(vim.split(query, ""))
			end,
		})
	end

	pick.builtin.files()
end

vim.api.nvim_create_user_command("Fd", fd, { nargs = "?", desc = "Find file (pre-filtered)" })
