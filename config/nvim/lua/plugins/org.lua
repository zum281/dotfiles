require("orgmode").setup({
	org_agenda_files = "~/org/**/*.org",
	org_default_notes_file = "~/org/refile.org",
	mappings = {
		global = {
			org_agenda = false,
			org_capture = false,
		},
	},
})
