local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
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
	local expandtab = vim.api.nvim_get_option_value("expandtab", { buf = 0 })

	local title = "spaces: "
	if not expandtab then
		title = "tab: "
	end

	return title .. vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
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
		if not schema or not schema.result or not schema.result[1].name then
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
						vim.bo.filetype == "snacks_picker_list"
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
			{
				"copilot",
				symbols = {
					status = {
						icons = {
							enabled = " ",
							sleep = " ",
							disabled = " ",
							warning = " ",
							unknown = " ",
						},
					},
					spinners = require("copilot-lualine.spinners").dots,
				},
			},
			lsp_progress,
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			},
			{
				function()
					-- Check if MCPHub is loaded
					if not vim.g.loaded_mcphub then
						return "󰐻 -"
					end

					local count = vim.g.mcphub_servers_count or 0
					local status = vim.g.mcphub_status or "stopped"
					local executing = vim.g.mcphub_executing

					-- Show "-" when stopped
					if status == "stopped" then
						return "󰐻 -"
					end

					-- Show spinner when executing, starting, or restarting
					if executing or status == "starting" or status == "restarting" then
						local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
						local frame = math.floor(vim.loop.now() / 100) % #frames + 1
						return "󰐻 " .. frames[frame]
					end

					return "󰐻 " .. count
				end,
				color = function()
					if not vim.g.loaded_mcphub then
						return { fg = "#6c7086" } -- Gray for not loaded
					end

					local status = vim.g.mcphub_status or "stopped"
					if status == "ready" or status == "restarted" then
						return { fg = "#50fa7b" } -- Green for connected
					elseif status == "starting" or status == "restarting" then
						return { fg = "#ffb86c" } -- Orange for connecting
					else
						return { fg = "#ff5555" } -- Red for error/stopped
					end
				end,
			},
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
