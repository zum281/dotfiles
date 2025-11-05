return {
	cmd = { "gopls" },
	filetypes = { "go" },
	root_markers = { {
		"go.mod",
		"go.work",
	}, ".git" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
				nilness = true, -- detects nil pointer dereferences
				unusedwrite = true, -- detects unused writes to variables
				useany = true, -- suggests using 'any' instead of 'interface{}'
			},
			staticcheck = true,
			-- Helpful for learning Go idioms:
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}
