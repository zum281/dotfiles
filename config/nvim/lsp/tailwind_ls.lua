return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "tailwindcss", "javascript", "javascriptreact", "typescriptreact" },
  root_markers = {
    { "tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts", "tailwind.config.mjs" },
    { "postcss.config.js",  "postcss.config.cjs",  "postcss.config.ts",  "postcss.config.mjs" },
    ".git",
  },
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = "ignore",
      },
    },
  },
}
