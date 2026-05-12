-- mini animate
require("mini.animate").setup({})

-- mini base16
require("mini.base16").setup({
	palette = require("mini.base16").mini_palette("#000000", "#ffffff", 49),
})

local black = "#000000"
vim.api.nvim_set_hl(0, "SignColumn", { bg = black })
vim.api.nvim_set_hl(0, "LineNr", { bg = black, fg = "#caffff" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = black })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = black })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = black })
vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = black })
vim.api.nvim_set_hl(0, "MiniFilesBorder", { bg = black })
vim.api.nvim_set_hl(0, "MiniFilesTitle", { bg = black })
vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { bg = black })
vim.api.nvim_set_hl(0, "MiniPickNormal", { bg = black })
vim.api.nvim_set_hl(0, "MiniPickBorder", { bg = black })
vim.api.nvim_set_hl(0, "MiniPickBorderText", { bg = black })
vim.api.nvim_set_hl(0, "MiniClueNormal", { bg = black })
vim.api.nvim_set_hl(0, "MiniClueBorder", { bg = black })
vim.api.nvim_set_hl(0, "MiniClueTitle", { bg = black })

-- statusline: force black bg on all groups, preserve fg from colorscheme
local function sl_hl(name)
	local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	hl.bg = 0x000000
	vim.api.nvim_set_hl(0, name, hl)
end

-- mini bufremove
require("mini.bufremove").setup({})

-- mini clue
local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		{ mode = { "n", "x" }, keys = "<Leader>" },
		{ mode = { "n", "x" }, keys = "g" },
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },
		{ mode = "i", keys = "<C-x>" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = { "n", "x" }, keys = "z" },
	},
	clues = {
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

sl_hl("MiniClueNextKey")
sl_hl("MiniClueNextKeyWithPostkeys")
sl_hl("MiniClueDescGroup")
sl_hl("MiniClueDescSingle")
sl_hl("MiniClueSeparator")

-- mini cursorword
require("mini.cursorword").setup({})

-- mini files
-- Open:       - (from keymaps.lua, opens at current file's directory)
-- Navigate:   h/l to go up/down directories, j/k to move within a column
-- Open file:  l or <CR> — both open the file and close the explorer
-- Manipulate files by editing the buffer directly:
--   Create:   type a new filename (or dir/ for directories)
--   Rename:   edit the filename text
--   Delete:   delete the line
--   Move:     dd in source dir, p in target dir
--   Confirm:  = to apply all pending changes
-- Close:      q or <Esc>
require("mini.files").setup({
	mappings = { close = "q" },
	windows = {
		max_number = math.huge,
		preview = true,
		width_focus = 40,
		width_nofocus = 20,
		width_preview = 40,
	},
})

-- mini.files resets row and height internally before firing WindowUpdate,
-- so WindowUpdate is the only reliable place to override both.
-- col is managed by mini.files for side-by-side columns — do not touch it.
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesWindowUpdate",
	callback = function(args)
		local config = vim.api.nvim_win_get_config(args.data.win_id)
		local target_row = vim.o.lines - 22
		local target_h = 20
		if config.row ~= target_row or config.height ~= target_h then
			config.row = target_row
			config.height = target_h
			vim.api.nvim_win_set_config(args.data.win_id, config)
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		vim.keymap.set("n", "<Esc>", function()
			require("mini.files").close()
		end, { buffer = buf_id, nowait = true })
		local go_in_close = function()
			require("mini.files").go_in({ close_on_file = true })
		end
		vim.keymap.set("n", "l", go_in_close, { buffer = buf_id })
		vim.keymap.set("n", "<CR>", go_in_close, { buffer = buf_id })
	end,
})

-- mini hipatterns
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		hex_color = hipatterns.gen_highlighter.hex_color(),
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
		deprecated = { pattern = "%f[%w]()DEPRECATED()%f[%W]", group = "DiagnosticWarn" },
		trail = { pattern = "%s+$", group = "Error" },
	},
})

-- mini icons
require("mini.icons").setup({})
MiniIcons.mock_nvim_web_devicons() -- redirect require("nvim-web-devicons") to mini.icons

-- mini statusline
-- Structure: [mode] [filepath] [git branch] ── [filetype] [line:col]
-- filepath: project-relative, truncated to always show full filename
require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 9999 })
			local git = MiniStatusline.section_git({ trunc_width = 40, icon = "" })
			local filetype = MiniStatusline.section_fileinfo({ trunc_width = math.huge })
			local location = MiniStatusline.section_location({ trunc_width = 9999 })

			-- project-relative path, truncated dir keeping full filename always visible
			local function filepath()
				local path = vim.api.nvim_buf_get_name(0)
				if path == "" then
					return "[No Name]"
				end
				if vim.bo.buftype ~= "" then
					return vim.fn.fnamemodify(path, ":t")
				end
				local rel = vim.fn.fnamemodify(path, ":.")
				local name = vim.fn.fnamemodify(path, ":t")
				local dir = vim.fn.fnamemodify(rel, ":h")
				if dir == "." or rel == path then
					return name
				end
				local parts = vim.split(dir, "/", { plain = true })
				if #parts > 2 then
					dir = "…/" .. parts[#parts - 1] .. "/" .. parts[#parts]
				end
				return dir .. "/" .. name
			end

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineFilename", strings = { filepath() .. "%m%r" } },
				{ hl = "MiniStatuslineDevinfo", strings = { git } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { filetype } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
	use_icons = true,
})

sl_hl("MiniStatuslineDevinfo")
sl_hl("MiniStatuslineFilename")
sl_hl("MiniStatuslineFileinfo")
sl_hl("MiniStatuslineInactive")

-- mini indentscope
require("mini.indentscope").setup({})

-- mini jump2d — label-based jump to any visible spot
-- Trigger: <CR>, then type the label letters shown on screen to jump
require("mini.jump2d").setup({})

-- mini notify — replaces vim.notify() with floating corner notifications
require("mini.notify").setup({})

-- mini pick — fuzzy finder (ivy-style bottom window)
-- Keymaps (defined in keymaps.lua):
--   <leader><space>  find files in project
--   <leader>/        live grep in project
--   <leader>h        help tags
--   <leader>s        LSP document symbols (functions, classes, types…)
--   <leader>g        git modified files (one entry per file)
-- Inside the picker:
--   <C-n>/<C-p>      move down/up
--   <Tab>            toggle preview
--   <C-x>            mark item, <C-a> mark all matched
--   <C-q>            send marked items to quickfix list
--   <C-Space>        refine (narrow results further)
--   <C-c> or <Esc>   close
require("mini.pick").setup({
	mappings = {
		choose_marked = "<C-q>",
	},
	window = {
		config = function()
			return {
				anchor = "SW",
				height = 20,
				width = vim.o.columns,
				row = vim.o.lines - 2,
				col = 0,
			}
		end,
	},
})

-- mini extra — additional pickers (LSP symbols, git files, diagnostics, etc.)
require("mini.extra").setup({})

-- mini completion — LSP-powered completion popup
-- Navigation:
--   <C-n> / <C-p>   move down / up in menu
--   <C-y>           confirm selection
--   <C-e>           dismiss menu
--   <C-Space>       manually trigger menu
--   <Tab> / <S-Tab> jump between snippet placeholders (mini.snippets)
require("mini.completion").setup({
	lsp_completion = {
		source_func = "omnifunc",
		auto_setup = false, -- set per buffer in LspAttach
	},
})

-- mini snippets — snippet engine for LSP snippet completions
require("mini.snippets").setup({
	expand = {
		insert = function(snippet, _)
			return MiniSnippets.default_insert(snippet, {
				empty_tabstop = "",
				empty_tabstop_final = "",
			})
		end,
	},
})

-- mini pairs — auto-closes brackets, quotes, etc. as you type
require("mini.pairs").setup({})
