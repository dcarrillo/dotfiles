local bufferline = require("bufferline")

local function is_buffer_loaded(name)
	local bufs = vim.api.nvim_list_bufs()

	for _, buffer in pairs(bufs) do
		if vim.fn.getbufvar(buffer, "&filetype") == name then
			return true
		end
	end

	return false
end

bufferline.setup({
	options = {
		close_command = "Bdelete! %d",
		right_mouse_command = "Bdelete! %d",
		offsets = {
			{ filetype = "snacks_picker_list", text = "", padding = 1 },
			{ filetype = "dapui_scopes", text = "", padding = 1 },
		},
		indicator = {
			style = "underline",
		},
		hover = {
			enabled = false,
		},
		separator_style = "slant",

		custom_areas = {
			left = function()
				local text = "  " .. string.gsub(vim.loop.cwd(), "^" .. os.getenv("HOME"), "~") .. "  "

				return { { text = text, fg = "#adbac7" } }
			end,
		},
	},
})
