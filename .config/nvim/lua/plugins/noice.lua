require("noice").setup({
	presets = {
		bottom_search = true,
		command_palette = false,
	},
	cmdline = {
		view = "cmdline",
	},
	views = {
		mini = {
			backend = "mini",
			align = "message-left",
			position = {
				row = -1,
				col = "0%",
			},
		},
	},
	routes = {
		{
			filter = {
				event = "lsp",
				find = "diagnostics",
			},
			opts = { skip = true },
		},
	},
})
