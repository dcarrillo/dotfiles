local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = "> ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--hidden", "--type=file", "--exclude=.git" },
		},
		live_grep = {
			additional_args = function()
				return { "--hidden", "-g", "!.git/" }
			end,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		fzf = {
			case_mode = "ignore_case",
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
