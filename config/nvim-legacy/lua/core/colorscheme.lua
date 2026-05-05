vim.cmd.colorscheme("moonfly")

-- Directory uses MoonflyBlue by default; relink to violet to match accent
vim.api.nvim_set_hl(0, "Directory", { link = "MoonflyViolet" })
