-- tailwind-aware fork of vscode-css-language-server, shipped inside tailwindcss-language-server (mason doesn't link it)
return {
  cmd = {
    vim.fn.stdpath("data")
      .. "/mason/packages/tailwindcss-language-server/node_modules/@tailwindcss/language-server/bin/css-language-server",
    "--stdio",
  },
  filetypes = { "tailwindcss" },
  -- server requests the "css" section per document; nil reply crashes its validation
  settings = {
    css = { validate = true },
  },
}
