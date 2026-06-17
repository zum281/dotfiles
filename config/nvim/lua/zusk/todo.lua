---Collect uppercase word-keywords from configured mini.hipatterns highlighters.
---@return string[] # Sorted, unique list (e.g. { "DEPRECATED", "FIXME", "NOTE", "TODO" })
local collect_keywords = function()
	local ok, hi = pcall(require, "mini.hipatterns")
	if not ok then
		vim.notify("Error loading mini.hipatterns: " .. hi, vim.log.levels.ERROR)
		return {}
	end
	local highlighters = hi.config.highlighters
	local seen = {}
	local out = {}

	for _, entry in pairs(highlighters) do
		if type(entry) == "table" and type(entry.pattern) == "string" then
			local kw = entry.pattern:match("%(%)(%w+)%(%)")
			if kw and not seen[kw] then
				seen[kw] = true
				table.insert(out, kw)
			end
		end
	end

	table.sort(out)
	return out
end

---Grep all matches of the keyword and populate the quickfix list.
---@param keyword string
local choose_kw = function(keyword)
	local res = vim.system(
		{ "rg", "--vimgrep", "--color=never", "-e", "\\b" .. keyword .. "\\b", "." },
		{ text = true }
	)
		:wait()

	local lines = vim.split(res.stdout, "\n", { plain = true, trimempty = true })

	if #lines == 0 then
		vim.notify("No matches for " .. keyword, vim.log.levels.INFO)
		return
	end

	vim.fn.setqflist({}, " ", {
		title = "Kws: " .. keyword,
		lines = lines,
		efm = "%f:%l:%c:%m",
	})
	vim.schedule(function()
		vim.cmd.copen()
	end)
end

local function todo()
	local kws = collect_keywords()
	if #kws == 0 then
		vim.notify("No hipattern keywords found", vim.log.levels.WARN)
		return
	end

	vim.ui.select(kws, { prompt = "" }, function(choice)
		if choice then
			choose_kw(choice)
		end
	end)
end

vim.api.nvim_create_user_command("Todo", todo, { desc = "Find hipatterns in codebase" })
