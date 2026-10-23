local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = "> ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
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
		file_browser = {
			entry_maker = require("real-icons.integrations.telescope_file_browser").entry_maker,
		},
		fzf = {
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
