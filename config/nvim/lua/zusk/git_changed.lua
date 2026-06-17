---Populate the quickfix list with all files that have uncommitted changes:
---unstaged, staged, and untracked. Deletions are excluded.
local git_changed = function()
	local repo_root = vim.fs.root(0, { ".git" })
	if not repo_root then
		vim.notify("Not inside a git repository", vim.log.levels.WARN)
		return
	end

	local out = vim.fn.systemlist({
		"sh",
		"-c",
		"cd " .. vim.fn.shellescape(repo_root) .. " && "
			.. "{ git ls-files --modified;"
			.. "git diff --cached --name-only --diff-filter=ACMR;"
			.. "git ls-files --others --exclude-standard; } | sort -u",
	})

	local items = {}
	for _, f in ipairs(out) do
		if f ~= "" then
			items[#items + 1] = { filename = repo_root .. "/" .. f, lnum = 1, col = 1, text = f }
		end
	end

	if #items == 0 then
		vim.notify("No changed files", vim.log.levels.INFO)
		return
	end

	vim.fn.setqflist({}, " ", { title = "Git Changed", items = items })
	vim.cmd("copen")
end

vim.api.nvim_create_user_command("GitChanged", git_changed, { desc = "Updated git files (quickfix)" })
