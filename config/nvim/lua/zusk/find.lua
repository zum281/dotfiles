---Return the list of file paths from `fd`.
---@param include_ignored boolean Include `.gitignore`d files when true.
---@return string[] files File paths produced by `fd --type f --hidden`
local function get_files(include_ignored)
	local cmd = { "fd", "--type", "f", "--hidden" }
	if include_ignored then
		table.insert(cmd, "--no-ignore")
	end
	return vim.fn.systemlist(cmd)
end

---Filter file paths with fzf.
---@param files string[] File paths to filter
---@param query string Search query
---@return string[] matches File paths matching `query`.
local function filter_files(files, query)
	if query == "" then
		return files
	end
	return vim.fn.systemlist({ "fzf", "--filter", query }, files)
end

---'findfunc' for `:find`. -I includes `.gitignore`d files.
---@param cmdarg string Find argument
---@param _ boolean Unused
---@return string[] files fzf-ranked file paths for the query
function _G.ZuskFind(cmdarg, _)
	local include_ignored = cmdarg == "-I" or cmdarg:match("^%-I%s") ~= nil
	local query = include_ignored and cmdarg:gsub("^%-I%s", "") or cmdarg
	return filter_files(get_files(include_ignored), query)
end

vim.o.findfunc = "v:lua.ZuskFind"
