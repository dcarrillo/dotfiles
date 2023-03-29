local status_ok, lsp_saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

lsp_saga.setup({
	ui = {
		border = "rounded",
		code_action_icon = "",
	},
	finder = {
		max_height = 0.5,
		min_width = 30,
		force_max_height = false,
		keys = {
			expand_or_jump = "<CR>",
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
		enable = false,
	},
})
