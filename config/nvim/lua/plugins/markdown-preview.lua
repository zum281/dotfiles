vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local d = ev.data
		if d.spec.name == "markdown-preview.nvim" and (d.kind == "install" or d.kind == "update") then
			if not d.active then
				vim.cmd.packadd("markdown-preview.nvim")
			end
			vim.fn["mkdp#util#install"]()
		end
	end,
})

vim.g.mkdp_refresh_slow = 1
