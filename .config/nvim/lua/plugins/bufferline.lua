require("bufferline").setup({
	options = {
		close_command = "Bdelete! %d",
		right_mouse_command = "Bdelete! %d",
		offsets = {
			{ filetype = "neo-tree", text = "", padding = 1 },
			{ filetype = "dapui_scopes", text = "", padding = 1 },
		},
		indicator = {
			style = "underline",
		},
		hover = {
			enabled = false,
		},
		separator_style = "slant",
	},
})
