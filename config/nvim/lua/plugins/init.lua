require("plugins.markdown-preview")

vim.pack.add({
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/esmuellert/nvim-eslint",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/mrjones2014/smart-splits.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/gelguy/wilder.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/iamcco/markdown-preview.nvim",
	"https://github.com/kryptamine/gruber-darker-renaissance",
})

require("plugins.colorscheme")

vim.pack.add({
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/NeogitOrg/neogit",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/antoinemadec/FixCursorHold.nvim",
	"https://github.com/marilari88/neotest-vitest",
}, { load = false })

require("plugins.mini")
require("plugins.mason")
require("plugins.conform")
require("plugins.eslint")
require("plugins.treesitter")
require("plugins.smart-splits")
require("plugins.autotag")
require("plugins.gitsigns")
require("plugins.diffview")
require("plugins.lint")
require("plugins.neogit")
require("plugins.neotest")
require("plugins.dap")
require("plugins.wilder")
require("plugins.telescope")
