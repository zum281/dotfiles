---@type string[]|nil Cached list of file paths from `fd`, or nil when unset.
local cache = nil

---Return the list of file paths, populating the cache on first call.
---@return string[] files Relative file paths produced by `fd --type f`.
local function get_files()
	if cache == nil then
		cache = vim.fn.systemlist("fd --type f")
	end
	return cache
end

---Filter file paths with fzf's non-interactive filter mode.
---Matches against the full path; whitespace acts as AND of fuzzy terms.
---@param files string[] Candidate file paths to filter.
---@param query string Search query; an empty string returns `files` unchanged.
---@return string[] matches File paths matching `query`, best first.
local function filter_files(files, query)
	if query == "" then
		return files
	end
	return vim.fn.systemlist({ "fzf", "--filter", query }, files)
end

---Open the files picker pre-filtered with a query.
---`:fd <filename>` opens mini.pick's file picker with `<filename>`
---already typed as the prompt, so results are filtered immediately.
---@param args table Command arguments table; `args.args` holds the raw query.
local fd = function(args)
	cache = nil
	local ok, pick = pcall(require, "mini.pick")
	if not ok then
		vim.notify("Error loading mini.pick: " .. pick, vim.log.levels.ERROR)
		return
	end

	local query = args.args
	if query ~= "" then
		local files = get_files()

		if vim.tbl_contains(files, query) then
			vim.cmd.edit(query)
			return
		end

		local res = filter_files(files, query)

		if #res == 1 then
			vim.cmd.edit(res[1])
			return
		end

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

vim.api.nvim_create_user_command("Fd", fd, {
	nargs = "?",
	desc = "Find file (pre-filtered)",
	complete = function(arg_lead)
		local files = get_files()
		return filter_files(files, arg_lead)
	end,
})

vim.cmd([[cnoreabbrev <expr> fd (getcmdtype() == ':' && getcmdline() ==# 'fd') ? 'Fd' : 'fd']])
