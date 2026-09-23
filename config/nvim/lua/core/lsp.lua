vim.lsp.inlay_hint.enable(true)

-- per project root: does nearest package.json depend on tailwindcss
local tailwind_roots = {}
local function uses_tailwind(bufnr)
	local root = vim.fs.root(bufnr, "package.json")
	if not root then
		return false
	end
	if tailwind_roots[root] == nil then
		local ok, pkg = pcall(vim.json.decode, table.concat(vim.fn.readfile(root .. "/package.json"), "\n"))
		tailwind_roots[root] = ok
			and type(pkg) == "table"
			and ((pkg.dependencies or {}).tailwindcss or (pkg.devDependencies or {}).tailwindcss) ~= nil
	end
	return tailwind_roots[root]
end

vim.filetype.add({
	filename = {
		["docker-compose.yaml"] = "yaml.docker-compose",
		["docker-compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
	},
	extension = {
		-- css in tailwind projects gets its own ft so tailwind_css_ls attaches instead of css_ls
		css = function(_, bufnr)
			return uses_tailwind(bufnr) and "tailwindcss" or "css"
		end,
	},
})

vim.lsp.enable({
	"bash_ls",
	"clang_ls",
	"lua_ls",
	"ts_ls",
	"emmet_ls",
	"css_ls",
	"css_vars_ls",
	"tailwind_ls",
	"tailwind_css_ls",
	"yaml_ls",
	"go_ls",
	"sql_ls",
	"pyright_ls",
	"ruff_ls",
	"jdtls_ls",
	"racket_ls",
	"rust_analyzer",
	"docker_ls",
	"docker_compose_ls",
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
