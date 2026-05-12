vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Build strudel.nvim after install/update",
	callback = function(args)
		local data = args.data or {}
		local spec = data.spec or {}
		if spec.name ~= "strudel.nvim" then return end
		if data.kind ~= "install" and data.kind ~= "update" then return end

		local path = data.path
		if not path or vim.fn.isdirectory(path) == 0 then return end

		vim.notify("strudel.nvim: running npm ci...", vim.log.levels.INFO)
		vim.system(
			{ "npm", "ci" },
			{ cwd = path },
			vim.schedule_wrap(function(out)
				if out.code == 0 then
					vim.notify("strudel.nvim: npm ci complete", vim.log.levels.INFO)
				else
					vim.notify("strudel.nvim: npm ci failed\n" .. (out.stderr or ""), vim.log.levels.ERROR)
				end
			end)
		)
	end,
})

require("strudel").setup()
