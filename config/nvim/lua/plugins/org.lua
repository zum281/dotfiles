require("orgmode").setup({
	org_agenda_files = "~/org/**/*.org",
	org_default_notes_file = "~/org/refile.org",
	org_todo_keywords = { "TODO", "PROGRESS", "|", "DONE" },
	org_capture_templates = {
		t = {
			description = "Task",
			template = "* TODO [#%^{Priority|A|B|C}] %^{Title} :%^{Project}:\n%?",
			target = "~/org/refile.org",
		},
	},
	mappings = {
		global = {
			org_agenda = false,
			org_capture = false,
		},
	},
})
