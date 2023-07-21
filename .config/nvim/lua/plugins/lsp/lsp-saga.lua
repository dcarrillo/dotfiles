require("lspsaga").setup({
	ui = {
		border = "rounded",
		code_action_icon = "",
	},
	finder = {
		max_height = 0.5,
		min_width = 30,
		force_max_height = false,
		default = "def+tyd+ref+imp",
		keys = {
			toggle_or_open = "<CR>",
		},
	},
	preview = {
		lines_above = 6,
	},
	outline = {
		win_width = 55,
		auto_preview = false,
	},
	symbol_in_winbar = {
		enable = true,
		folder_level = 3,
	},
})
