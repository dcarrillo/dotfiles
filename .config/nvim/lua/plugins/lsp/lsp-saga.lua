local status_ok, lsp_saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

lsp_saga.setup({
	ui = {
		border = "rounded",
		code_action_icon = "",
		colors = {
			normal_bg = "#222436",
		},
	},
	preview = {
		lines_above = 5,
	},
	outline = {
		win_width = 45,
		auto_preview = false,
	},
	symbol_in_winbar = {
		enable = false,
	},
})
