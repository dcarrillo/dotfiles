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
			focusable = false,
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
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
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
		{
			filter = {
				event = "msg_show",
				kind = "",
				find = "escrito", -- localized for "written"
			},
			opts = { skip = true },
		},
		{
			filter = {
				event = "notify",
				kind = "debug",
			},
			opts = { skip = true },
		},
	},
})
