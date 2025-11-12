return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "typescriptreact",
    "typescript",
    "javascriptreact",
    "javascript"
  },
  root_markers = {
    {
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
    },
    ".git"
  }
}
