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
	symbols = { error = " ", warn = " " },
	colored = false,
	always_visible = false,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = "", modified = "", removed = "" }, -- changes diff symbols
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = false,
}

local location = {
	"location",
	padding = 0,
}

local spaces = function()
	local expandtab = vim.api.nvim_buf_get_option(0, "expandtab")

	local title = "spaces: "
	if not expandtab then
		title = "tab: "
	end

	return title .. vim.api.nvim_buf_get_option(0, "shiftwidth")
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
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = " " },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { diagnostics, { "filename", path = 3 } },
		lualine_x = {
			{ gitblame.get_current_blame_text, cond = gitblame.is_blame_text_available },
			diff,
			spaces,
			"encoding",
			filetype,
		},
		lualine_y = { location },
		lualine_z = { "progress" },
	},
})
