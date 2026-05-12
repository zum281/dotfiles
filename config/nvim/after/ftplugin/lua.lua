local love = require("zusk.love")
local root = vim.fs.root(0, { "main.lua" })

vim.api.nvim_buf_create_user_command(0, "Love", function()
	if root == nil then
		vim.notify("Not a LÖVE project (no main.lua found)", vim.log.levels.ERROR)
		return
	else
		love.run(root)
	end
end, { desc = "Start LÖVE" })

vim.api.nvim_buf_create_user_command(0, "LoveStop", function()
	love.stop()
end, { desc = "Stop LÖVE" })
