return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"typescriptreact",
		"typescript",
		"javascriptreact",
		"javascript",
	},
	root_markers = {
		{
			"package.json",
			"tsconfig.json",
			"jsconfig.json",
		},
		".git",
	},
	settings = {
		typescript = {
			referencesCodeLens = { enabled = true },
			implementationsCodeLens = { enabled = true },
			inlayHints = {
				includeInlayParameterNameHints = "literals", -- "none" | "literals" | "all"
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			referencesCodeLens = { enabled = true },
			implementationsCodeLens = { enabled = true },
			inlayHints = {
				includeInlayParameterNameHints = "literals",
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
}
