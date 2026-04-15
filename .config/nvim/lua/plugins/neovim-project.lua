local projects = function()
	local projects_path = vim.fn.expand("~/.config/nvim/neovim-projects.json")
	local data = require("util.files").read(projects_path)

	if data then
		local ok, decoded = pcall(vim.json.decode, data)
		return ok and decoded or {}
	end

	return {}
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
