---@class QfFileItem
---@field bufnr integer Buffer number of the file containing qf entries.
---@field count integer Number of qf entries pointing at this buffer.
---@field path string Path relative to cwd when possible; absolute otherwise.
---@field first_index integer 1-based index in the qf list of this file's first entry; used with `:cc N` to jump.
---@field text? string Display string for mini.pick (matchable + shown). Set by show_qf_files; absent on raw collect output.

---Group the current quickfix list by file and count entries per buffer.
---@return QfFileItem[] # One item per file with at least one qf entry; empty if qf is empty or holds only file-less entries.
local collect_qf_files = function()
	local qf = vim.fn.getqflist()
	if #qf == 0 then
		return {}
	end
	local counts = {}
	local first_index = {}

	for i, entry in ipairs(qf) do
		if entry.bufnr ~= 0 then
			if not counts[entry.bufnr] and not first_index[entry.bufnr] then
				counts[entry.bufnr] = 0
				first_index[entry.bufnr] = i
			end
			counts[entry.bufnr] = counts[entry.bufnr] + 1
		end
	end

	local items = {}
	for bufnr, count in pairs(counts) do
		local path = vim.api.nvim_buf_get_name(bufnr)
		local relative_path = vim.fn.fnamemodify(path, ":.")
		table.insert(items, { bufnr = bufnr, count = count, path = relative_path, first_index = first_index[bufnr] })
	end
	return items
end

---Jump to the first qf entry belonging to the chosen file.
---Scheduled because mini.pick's choose callback runs during teardown.
---@param file QfFileItem
local choose_file = function(file)
	vim.schedule(function()
		vim.cmd("cc " .. file.first_index)
	end)
end

---Sort items by path, attach a display string, and open mini.pick over them.
---@param qf QfFileItem[]
local show_qf_files = function(qf)
	local ok, pick = pcall(require, "mini.pick")
	if not ok then
		vim.notify("Error loading mini.pick: " .. pick, vim.log.levels.ERROR)
		return
	end

	table.sort(qf, function(a, b)
		return a.path < b.path
	end)
	for _, item in ipairs(qf) do
		item.text = item.path
	end

	pick.start({ source = { items = qf, name = "QfFiles", choose = choose_file } })
end

local qf_files = function()
	local qf = collect_qf_files()

	if #qf == 0 then
		vim.notify("Nothing found in quickfix list", vim.log.levels.INFO)
		return
	end

	vim.cmd.cclose()

	show_qf_files(qf)
end

vim.api.nvim_create_user_command("QfFiles", qf_files, { desc = "Quickfix list files" })
