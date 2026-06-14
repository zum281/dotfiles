local cache = nil

local function get_files()
	if cache == nil then
		cache = vim.fn.systemlist("fd --type f")
	end
	return cache
end

local function filter_files(files, query)
	local res = {}
	for _, file in pairs(files) do
		local basename = vim.fn.fnamemodify(file, ":t"):lower()
		if basename:find(query:lower(), 1, true) then
			table.insert(res, file)
		end
	end
	return res
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
		local res = filter_files(files, query)

		if res == nil or #res == 0 then
			vim.notify("No matches found for '" .. query .. "'", vim.log.levels.INFO)
			return
		end

		if #res == 1 then
			vim.cmd.edit(res[1])
			return
		else
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniPickStart",
				once = true,
				callback = function()
					pick.set_picker_query(vim.split(query, ""))
				end,
			})
		end
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
