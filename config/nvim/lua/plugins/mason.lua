require("mason").setup({})

-- LSP servers + formatters
local ensure_installed = {
  "bash-language-server",       -- bash_ls
  "clangd",                     -- clang_ls
  "lua-language-server",        -- lua_ls
  "typescript-language-server", -- ts_ls
  "emmet-language-server",      -- emmet_ls
  "css-lsp",                     -- css_ls  (vscode-css-language-server)
  "css-variables-language-server",-- css_vars_ls
  "tailwindcss-language-server", -- tailwind_ls
  "yaml-language-server",        -- yaml_ls
  "gopls",                       -- go_ls
  "sqls",                        -- sql_ls
  "pyright",                     -- pyright_ls
  "ruff",                        -- ruff_ls + ruff_format
  -- formatters
  "stylua",
  "prettierd",
  "goimports",
  "clang-format",
  "shfmt",
}

local registry = require("mason-registry")
registry.refresh(function()
  for _, name in ipairs(ensure_installed) do
    local ok, pkg = pcall(registry.get_package, name)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end)
