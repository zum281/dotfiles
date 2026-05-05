vim.g.copilot_no_tab_map = true
-- <C-l> accepts suggestion (insert mode only — no conflict with smart-splits normal mode)
vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<cr>')", { silent = true, expr = true })
