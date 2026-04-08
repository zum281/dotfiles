vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 2

vim.opt.showmode = false
vim.opt.pumheight = 20
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.synmaxcol = 300

vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true

vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
vim.g.netrw_localcopydircmd = "cp -r"

-- grep with ripgrep
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

-- suppress provider warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
