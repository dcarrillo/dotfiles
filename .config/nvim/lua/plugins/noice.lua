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
	messages = {
		view_search = false,
	},
	routes = {
		{
			filter = {
				event = "lsp",
				find = "diagnostics",
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "escrito", -- localized for "written"
			},
			opts = { skip = true },
		},
	},
})
