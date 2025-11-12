return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = { 'nvim-mini/mini.nvim' },
  opts = {
    animate = { enabled = true },
    picker = { enabled = true },
    git = { enabled = true },
    image = { enabled = true },
    lazygit = { enabled = true },
    scratch = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true }
  }
}
