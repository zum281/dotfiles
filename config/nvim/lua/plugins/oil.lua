local ns = vim.api.nvim_create_namespace("oil_dir_header")

local function ensure_header(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) or not vim.b[bufnr].oil_ready then
		return
	end
	local dir = require("oil").get_current_dir(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local parent = lines[1]
	if not dir or not parent or not parent:match("^/000 .*%.%./$") then
		return
	end
	local prefix = parent:sub(1, -4)
	local header = prefix .. dir
	if vim.tbl_contains(lines, header) then
		return
	end
	local modified = vim.bo[bufnr].modified
	local undolevels = vim.bo[bufnr].undolevels
	local modifiable = vim.bo[bufnr].modifiable
	vim.bo[bufnr].modifiable = true
	vim.bo[bufnr].undolevels = -1
	vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, { header })
	vim.bo[bufnr].undolevels = undolevels
	vim.bo[bufnr].modifiable = modifiable
	vim.bo[bufnr].modified = modified
	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
	vim.api.nvim_buf_set_extmark(bufnr, ns, 0, 0, { end_col = #prefix, conceal = "" })
	vim.api.nvim_buf_set_extmark(bufnr, ns, 0, #prefix, { end_col = #header, hl_group = "OilDirHeader" })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "OilEnter",
	callback = function(args)
		local bufnr = args.data.buf
		ensure_header(bufnr)
		vim.api.nvim_buf_attach(bufnr, false, {
			on_lines = function()
				vim.schedule(function()
					ensure_header(bufnr)
				end)
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("SessionLoadPre", {
	callback = function()
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_get_name(bufnr):match("^oil://") then
				vim.api.nvim_buf_delete(bufnr, { force = true })
			end
		end
	end,
})

require("oil").setup({
	default_file_explorer = true,
	view_options = { show_hidden = true },
	columns = {
		"icon",
		{ "permissions", highlight = "OilPermissions" },
		{ "size", highlight = "Number" },
		{ "mtime", format = "%Y-%m-%d %H:%M:%S", highlight = "Comment" },
	},
})
