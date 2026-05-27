local map = function(lhs, plug)
	vim.keymap.set("n", lhs, plug, { buffer = 0, remap = true })
end

map("gu", "<Plug>(InfoUp)")
map("gn", "<Plug>(InfoNext)")
map("gp", "<Plug>(InfoPrev)")
map("gm", "<Plug>(InfoMenu)")
map("gf", "<Plug>(InfoFollow)")
