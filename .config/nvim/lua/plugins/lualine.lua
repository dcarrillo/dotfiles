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

	venv = require("venv-selector").get_active_venv()
	if venv then
		return string.format(" %s", string.match(venv, "[^/]+$"))
	end

	return ""
end

local get_filetype = function()
	local ft = vim.bo.filetype or ""

	if ft == "yaml" then
		local schema = require("yaml-companion").get_buf_schema(0)
		if schema.result[1].name == "none" then
			return ft
		end

		return ft .. " (" .. schema.result[1].name .. ")"
	else
		return ft
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
			{
				"filename",
				path = 1,
				cond = function()
					if
						vim.bo.filetype == "neo-tree"
						or vim.bo.filetype == "mason"
						or vim.bo.filetype == "lazy"
						or vim.bo.filetype == "help"
						or vim.bo.filetype == "starter"
						or vim.bo.filetype == "TelescopePrompt"
						or vim.bo.filetype == "noice"
					then
						return false
					end

					return true
				end,
			},
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
			{ get_filetype, separator = "" },
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	extensions = { "lazy", "mason", "trouble" },
})
