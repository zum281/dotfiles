local job = nil

---@param root string
local run = function(root)
	if job ~= nil then
		vim.notify("LÖVE already running, use :LoveStop first", vim.log.levels.ERROR)
		return
	end

	job = vim.system({ "love", root }, {}, function(obj)
		job = nil
		vim.schedule(function()
			if obj.signal ~= 0 then
				vim.notify("LÖVE stopped")
			elseif obj.code == 0 then
				vim.notify("LÖVE exited")
			else
				vim.notify("LÖVE crashed (exit " .. obj.code .. ")", vim.log.levels.WARN)
			end
		end)
	end)

	vim.notify("Launched LÖVE at " .. root)
end

local stop = function()
	if job == nil then
		vim.notify("No LÖVE process running")
		return
	end
	job:kill(15)
end

return { run = run, stop = stop }
