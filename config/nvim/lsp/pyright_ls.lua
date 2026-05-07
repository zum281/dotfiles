return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  handlers = {
    ["$/progress"] = function() end,
  },
  root_markers = {
    { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json" },
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none",
          reportUnusedVariable = "none",
        },
      },
    },
  },
}
