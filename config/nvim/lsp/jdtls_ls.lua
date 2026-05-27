local workspace = vim.fn.stdpath("cache")
  .. "/jdtls/"
  .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

return {
  cmd = { "jdtls", "-data", workspace },
  filetypes = { "java" },
  root_markers = {
    "pom.xml",
    "build.gradle",
    "build.gradle.kts",
    "settings.gradle",
    ".git",
    "mvnw",
    "gradlew",
  },
  -- For projects without a pom.xml/build.gradle, jdtls creates an "invisible project"
  -- and auto-detects source roots by walking into the deepest dir containing .java files.
  -- That breaks package-mirrored layouts (src/com/foo/Bar.java). Pin the source root to src/.
  init_options = {
    bundles = vim.fn.glob(
      vim.fn.stdpath("data")
        .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
      true,
      true
    ),
    settings = {
      java = {
        project = {
          sourcePaths = { "src" },
          outputPath = "bin",
        },
      },
    },
  },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
        },
      },
      sources = {
        organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
      },
      project = {
        sourcePaths = { "src" },
        outputPath = "bin",
      },
    },
  },
}
