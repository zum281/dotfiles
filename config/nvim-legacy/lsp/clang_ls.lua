return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--fallback-style=llvm",
		"--pch-storage=memory",
	},
	filetypes = { "c" },
	root_markers = { "compile_commands.json", ".clangd", "Makefile", "CMakeLists.txt" },
}
