---Picker over all files with uncommitted changes:
---unstaged, staged, and untracked.
---Deletions are excluded
local git_changed = function()
	local repo_root = vim.fs.root(0, { ".git" })
	if not repo_root then
		vim.notify("Not inside a git repository", vim.log.levels.WARN)
		return
	end

	local ok, pick = pcall(require, "mini.pick")
	if not ok then
		vim.notify("Error loading mini.pick: " .. pick, vim.log.levels.ERROR)
		return
	end

	local command = {
		"sh",
		"-c",
		"{ git ls-files --modified;"
			.. "git diff --cached --name-only --diff-filter=ACMR;"
			.. "git ls-files --others --exclude-standard; } | sort -u",
	}

	pick.builtin.cli({ command = command }, { source = { name = "Git Changed", cwd = repo_root } })
end

vim.api.nvim_create_user_command("GitChanged", git_changed, { desc = "Updated git files picker" })
