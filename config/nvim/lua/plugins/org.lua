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

	org_agenda_custom_commands = {
		d = {
			description = "Done",
			types = {
				{
					type = "tags",
					match = 'TODO="DONE"',
					org_agenda_overriding_header = "Global list of TODO items of type: DONE",
				},
			},
		},
		p = {
			description = "In progress",
			types = {
				{
					type = "tags_todo",
					match = 'TODO="PROGRESS"',
					org_agenda_overriding_header = "Global list of TODO items of type: PROGRESS",
				},
			},
		},
	},
	mappings = {
		global = {
			org_agenda = false,
			org_capture = false,
		},
	},
})
