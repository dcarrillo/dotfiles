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
	separator = "",
}

local lsp_progress = {
	"lsp_progress",
	display_components = { "spinner" },
	spinner_symbols = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" },
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

local get_schema = function()
	local ft = vim.bo.filetype or ""

	if ft == "yaml" then
		local schema = require("yaml-companion").get_buf_schema(0)
		if schema.result[1].name == "none" then
			return ""
		end

		return "(" .. schema.result[1].name .. ")"
	else
		return ""
	end
end

local gitblame = require("gitblame")

vim.g.gitblame_date_format = "%r"
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_message_template = "<author>, <date>"

require("lualine").setup({
	options = {
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", venv },
		lualine_c = {
			diagnostics,
			{ "filename", path = 1 },
			lsp_progress,
			{
				require("noice").api.status.search.get,
				cond = require("noice").api.status.search.has,
				color = { fg = "#c69026" },
			},
		},
		lualine_x = {
			{ gitblame.get_current_blame_text, cond = gitblame.is_blame_text_available },
			diff,
			spaces,
			"encoding",
			filetype,
			{ get_schema, separator = "" },
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
