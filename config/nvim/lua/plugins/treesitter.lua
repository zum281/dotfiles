local ensure_installed = {
	"awk",
	"bash",
	"c",
	"c3",
	"cmake",
	"comment",
	"css",
	"csv",
	"diff",
	"dockerfile",
	"git_config",
	"gitcommit",
	"gitignore",
	"go",
	"haskell",
	"html",
	"java",
	"javascript",
	"jsdoc",
	"json",
	"json5",
	"markdown",
	"mermaid",
	"lua",
	"luadoc",
	"python",
	"query",
	"regex",
	"robots_txt",
	"scheme",
	"scss",
	"sql",
	"tmux",
	"toml",
	"tsx",
	"typescript",
	"vimdoc",
	"xml",
	"yaml",
}

local ok, ts_config = pcall(require, "nvim-treesitter.config")
if ok then
	local installed = ts_config.get_installed()
	local to_install = vim.iter(ensure_installed)
		:filter(function(p)
			return not vim.tbl_contains(installed, p)
		end)
		:totable()
	if #to_install > 0 then
		require("nvim-treesitter").install(to_install)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local max_filesize = 100 * 1024
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
		if ok and stats and stats.size > max_filesize then
			return
		end
		pcall(vim.treesitter.start)
		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
