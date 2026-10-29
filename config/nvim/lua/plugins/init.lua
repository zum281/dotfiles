vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/esmuellert/nvim-eslint",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/mrjones2014/smart-splits.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/gelguy/wilder.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/kryptamine/gruber-darker-renaissance",
	"https://github.com/echasnovski/mini.surround",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/FylerOrg/fyler.nvim",
})

require("plugins.colorscheme")

vim.pack.add({
	"https://github.com/NeogitOrg/neogit",
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/marilari88/neotest-vitest",
}, { load = false })

require("plugins.mason")
require("plugins.conform")
require("plugins.eslint")
require("plugins.treesitter")
require("plugins.smart-splits")
require("plugins.gitsigns")
require("plugins.neogit")
require("plugins.neotest")
require("plugins.wilder")
require("plugins.telescope")
require("plugins.mini-surround")
require("plugins.fidget")
require("plugins.fyler")
