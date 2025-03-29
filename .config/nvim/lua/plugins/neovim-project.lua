local projects = function()
	local data = require("util.files").read(os.getenv("HOME") .. "/.config/nvim/neovim-projects.json")
	if data then
		return vim.json.decode(data)
	else
		return {}
	end
end

require("neovim-project").setup({
	projects = projects(),
	last_session_on_startup = false,
	dashboard_mode = false,
	filetype_autocmd_timeout = 0,
	session_manager_opts = {
		autosave_ignore_filetypes = {
			"snacks_picker_list",
			"trouble",
			"grug-far",
			"copilot-chat",
			"trouble",
		},
	},
})
