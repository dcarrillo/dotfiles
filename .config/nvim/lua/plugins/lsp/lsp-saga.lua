local status_ok, lsp_saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

lsp_saga.init_lsp_saga({
	border_style = "rounded",
	code_action_icon = "",
	preview_lines_above = 5,
	show_outline = {
		win_width = 45,
		auto_preview = false,
	},
})
