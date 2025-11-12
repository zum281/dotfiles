return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yml" },
  root_markers = {
    { ".yamlrc", ".yamlrc.yaml" },
    ".git",
  },
}
