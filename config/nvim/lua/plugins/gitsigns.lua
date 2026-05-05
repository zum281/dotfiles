local black = "#000000"
local sign_groups = {
  "GitSignsAdd", "GitSignsChange", "GitSignsDelete", "GitSignsTopdelete", "GitSignsChangedelete", "GitSignsUntracked",
  "GitSignsStagedAdd", "GitSignsStagedChange", "GitSignsStagedDelete", "GitSignsStagedTopdelete", "GitSignsStagedChangedelete",
}
for _, group in ipairs(sign_groups) do
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  hl.bg = black
  vim.api.nvim_set_hl(0, group, hl)
end

require("gitsigns").setup({
  signs = {
    add          = { text = "█" },
    change       = { text = "█" },
    delete       = { text = "█" },
    topdelete    = { text = "█" },
    changedelete = { text = "█" },
  },
  signs_staged_enable = true,
  current_line_blame  = true,
  current_line_blame_opts = { delay = 300 },
  current_line_blame_formatter = "<author> . <author_time:%d-%m-%Y %H:%M> . <summary>",
})
