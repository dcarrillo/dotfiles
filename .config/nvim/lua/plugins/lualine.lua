local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = "!" },
	colored = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = "+", modified = "", removed = "" },
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	colored = false,
}

local lsp_progress = {
	"lsp_progress",
	display_components = { "spinner" },
	spinner_symbols = { "⠈⠁", "⠈⠑", "⠈⠱", "⠈⡱", "⢀⡱", "⢄⡱" },
}

local spaces = function()
	local expandtab = vim.api.nvim_buf_get_option(0, "expandtab")

	local title = "spaces: "
	if not expandtab then
		title = "tab: "
	end

	return title .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local venv = function()
	local venv = os.getenv("VIRTUAL_ENV")
	if venv then
		return string.format(" %s", string.match(venv, "[^/]+$"))
	end

	return ""
end

local gitblame_status_ok, gitblame = pcall(require, "gitblame")
if not gitblame_status_ok then
	return
end

vim.g.gitblame_date_format = "%r"
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_message_template = "<author>, <date>"

lualine.setup({
	options = {
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", venv },
		lualine_c = { diagnostics, { "filename", path = 3 }, "searchcount", lsp_progress },
		lualine_x = {
			{ gitblame.get_current_blame_text, cond = gitblame.is_blame_text_available },
			diff,
			spaces,
			"encoding",
			filetype,
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
