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
		m = {
			description = "Meeting",
			template = "* Meeting %^{Title|} %t :meeting:%^{Project}:\n%?",
			target = "~/org/meetings.org",
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
		n = {
			description = "Search meeting notes",
			types = {
				{
					type = "search",
					org_agenda_files = { "~/org/meetings.org" },
					org_agenda_overriding_header = "Search results in MEETING NOTES",
				},
			},
		},
		l = {
			description = "List meetings",
			types = {
				{
					type = "tags",
					match = "+meeting",
					org_agenda_files = { "~/org/meetings.org" },
					org_agenda_overriding_header = "Global list of MEETING NOTES",
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
