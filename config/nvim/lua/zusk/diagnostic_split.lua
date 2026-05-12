---Dump the current buffer diagnostics into a scratch buffer split below
local diagnostic_split = function()
	local diags = vim.diagnostic.get(0)
	if #diags == 0 then
		vim.notify("No diagnostics in this buffer", vim.log.levels.INFO)
		return
	end

	local lines = {}
	for i, d in ipairs(diags) do
		if i > 1 then
			table.insert(lines, "")
			table.insert(lines, "---")
			table.insert(lines, "")
		end
		local severity = vim.diagnostic.severity[d.severity]
		local source = d.source or "?"
		local code = d.code and (" [" .. tostring(d.code) .. "]") or ""
		table.insert(lines, ("[%s] %s%s"):format(severity, source, code))
		for _, line in ipairs(vim.split(d.message, "\n", { plain = true })) do
			table.insert(lines, line)
		end
	end

	vim.cmd("botright new")
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = false
	vim.bo[buf].filetype = "markdown"
	pcall(vim.api.nvim_buf_set_name, buf, "Diagnostic detail")
	vim.cmd("resize " .. math.min(#lines + 1, math.floor(vim.o.lines * 0.4)))
	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true, desc = "Close diagnostic detail" })
end

vim.api.nvim_create_user_command(
	"DiagnosticSplit",
	diagnostic_split,
	{ desc = "Open buffer diagnostics in a scratch split" }
)
