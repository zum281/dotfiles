-- diffview — side-by-side diff viewer, used by neogit (<enter> on file or d on commit)
-- q closes the entire diffview layout and returns to neogit
require("diffview").setup({
  keymaps = {
    view = {
      { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
    },
    file_panel = {
      { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
    },
    file_history_panel = {
      { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
    },
  },
})
