---@class HipatternItem
---@field text string Lowercase keyword shown in the picker (also used for fuzzy matching).
---@field keyword string Original keyword as configured in mini.hipatterns; used for grep + qf title.

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
			local kw = entry.pattern:match("%(%)(%u+)%(%)")
			if kw and not seen[kw] then
				seen[kw] = true
				table.insert(out, kw)
			end
		end
	end

	table.sort(out)
	return out
end

---Grep all matches of the picked keyword and populate the quickfix list.
---@param item HipatternItem
local choose_kw = function(item)
	local res = vim.system(
		{ "rg", "--vimgrep", "--color=never", "-e", "\\b" .. item.keyword .. "\\b", "." },
		{ text = true }
	)
		:wait()

	local lines = vim.split(res.stdout, "\n", { plain = true, trimempty = true })

	if #lines == 0 then
		vim.notify("No matches for " .. item.keyword, vim.log.levels.INFO)
		return
	end

	vim.fn.setqflist({}, " ", {
		title = "Kws: " .. item.keyword,
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
	local ok, pick = pcall(require, "mini.pick")
	if not ok then
		vim.notify("Error loading mini.pick: " .. pick, vim.log.levels.ERROR)
	end

	local items = vim.tbl_map(function(kw)
		return { text = kw:lower(), keyword = kw }
	end, kws)

	pick.start({
		source = {
			items = items,
			name = "Kws",
			choose = choose_kw,
		},
		window = {
			config = function()
				local height = math.min(#items + 2, 10)
				local width = 40
				return {
					relative = "editor",
					anchor = "NW",
					row = math.floor((vim.o.lines - height) / 2),
					col = math.floor((vim.o.columns - width) / 2),
					height = height,
					width = width,
					border = "rounded",
				}
			end,
		},
	})
end

vim.api.nvim_create_user_command("Todo", todo, { desc = "Find hipatterns in codebase" })
