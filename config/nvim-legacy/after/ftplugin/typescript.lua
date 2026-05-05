local root = vim.fs.root(0, { "tsconfig.json", "package.json" })

vim.bo.makeprg = "npx tsc --noEmit"
vim.bo.errorformat = "%f(%l\\,%c): %trror TS%n: %m,%f(%l\\,%c): %tarning TS%n: %m,%-G%.%#"

local function with_root(fn)
	if not root then
		fn()
		return
	end
	local orig = vim.fn.chdir(root)
	fn()
	vim.fn.chdir(orig)
end

vim.api.nvim_buf_create_user_command(0, "Make", function()
	with_root(function()
		vim.cmd("make")
		vim.cmd("copen")
	end)
end, { desc = "tsc project check" })

vim.api.nvim_buf_create_user_command(0, "Lint", function()
	local raw = vim.fn.system("npx eslint . --cache --format json 2>/dev/null")
	local ok, decoded = pcall(vim.json.decode, raw)
	if not ok then
		vim.notify("ESLint: failed to parse output", vim.log.levels.ERROR)
		return
	end
	local items = {}
	for _, file in ipairs(decoded) do
		for _, msg in ipairs(file.messages) do
			table.insert(items, {
				filename = file.filePath,
				lnum = msg.line,
				col = msg.column,
				text = msg.message .. (msg.ruleId and (" [" .. msg.ruleId .. "] ") or ""),
				type = msg.severity == 2 and "E" or "W",
			})
		end
	end
	vim.fn.setqflist({}, "r", { title = "ESLint", items = items })
	vim.cmd("copen")
end, { desc = "eslint project check" })
