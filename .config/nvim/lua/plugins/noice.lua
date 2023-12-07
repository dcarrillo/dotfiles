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
				row = "98%",
				col = "0%",
			},
			border = {
				style = "rounded",
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
		{
			view = "popup",
			filter = {
				find = "File larger than",
			},
			opts = {
				size = {
					width = 100,
					height = 4,
				},
			},
		},
	},
})
