local colorscheme = "tokyonight"

require("tokyonight").setup({
	style = "moon",
	styles = {
		sidebars = "normal",
		floats = "normal",
	},
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
