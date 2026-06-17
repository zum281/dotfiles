vim.lsp.inlay_hint.enable(true)

vim.lsp.enable({
  "bash_ls",
  "clang_ls",
  "lua_ls",
  "ts_ls",
  "emmet_ls",
  "css_ls",
  "css_vars_ls",
  "tailwind_ls",
  "yaml_ls",
  "go_ls",
  "sql_ls",
  "pyright_ls",
  "ruff_ls",
  "jdtls_ls",
  "racket_ls",
})

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local provider = client and client.server_capabilities.completionProvider
    if not provider then
      return
    end
    -- autotrigger only fires on triggerCharacters; add word chars to complete as you type
    local chars = provider.triggerCharacters or {}
    for c = ("a"):byte(), ("z"):byte() do
      chars[#chars + 1] = string.char(c)
    end
    for c = ("A"):byte(), ("Z"):byte() do
      chars[#chars + 1] = string.char(c)
    end
    chars[#chars + 1] = "_"
    provider.triggerCharacters = chars
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end,
})
