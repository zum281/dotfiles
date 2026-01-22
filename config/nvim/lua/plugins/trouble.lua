return {
  "folke/trouble.nvim",
  dependencies = { "folke/todo-comments.nvim" },
  opts = {
    auto_close = false,
    auto_preview = true,
    focus = true,
    multiline = false,
    keys = {
      ["<esc>"] = "close",
    },
  },
  cmd = "Trouble",
}
