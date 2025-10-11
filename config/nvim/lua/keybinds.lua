local set = vim.keymap.set

-- Center screen when jumping
set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better window navigation
set("n", "<C-Left>", "<C-w>h", { desc = "Move to left window" })
set("n", "<C-Down>", "<C-w>j", { desc = "Move to bottom window" })
set("n", "<C-Up>", "<C-w>k", { desc = "Move to top window" })
set("n", "<C-Right>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing

-- leap
set({ "n", "x", "o" }, "s", "<Plug>(leap)")
set("n", "S", "<Plug>(leap-from-window)")
