require("conform").setup({
  formatters_by_ft = {
    lua            = { "stylua" },
    javascript     = { "prettierd", "prettier", stop_after_first = true },
    typescript     = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact= { "prettierd", "prettier", stop_after_first = true },
    javascriptreact= { "prettierd", "prettier", stop_after_first = true },
    html           = { "prettierd", "prettier", stop_after_first = true },
    css            = { "prettierd", "prettier", stop_after_first = true },
    json           = { "prettierd", "prettier", stop_after_first = true },
    markdown       = { "prettierd", "prettier", stop_after_first = true },
    go             = { "goimports" },
    c              = { "clang-format" },
    sh             = { "shfmt" },
    bash           = { "shfmt" },
  },
  formatters = {
    prettierd = { prepend_args = { "--html-whitespace-sensitivity=ignore" } },
    prettier  = { prepend_args = { "--html-whitespace-sensitivity=ignore" } },
  },
})
