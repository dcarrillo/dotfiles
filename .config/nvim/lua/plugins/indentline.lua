require("ibl").setup({
	indent = {
		char = "▏",
		tab_char = "▏",
	},
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
	},
	exclude = {
		filetypes = {
			"help",
			"mini.starter",
			"neo-tree",
			"Trouble",
			"lazy",
			"mason",
			"notify",
		},
	},
})
