local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
	return
end

wilder.setup({
	modes = { ":" },
})

wilder.set_option("use_python_remote_plugin", 1)

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.python_file_finder_pipeline({
			file_command = { "fd", "--hidden", "--type=file", "--exclude=.git" },
			dir_command = { "fd", "--hidden", "--type=directory", "--exclude=.git" },
			filters = { "fuzzy_filter", "difflib_sorter" },
		}),
		wilder.cmdline_pipeline({
			fuzzy = 2,
			fuzzy_filter = wilder.lua_fzy_filter(),
		})
	),
})

-- Better highlighting

local gradient = {
	"#f4468f",
	"#fd4a85",
	"#ff507a",
	"#ff566f",
	"#ff5e63",
	"#ff6658",
	"#ff704e",
	"#ff7a45",
	"#ff843d",
	"#ff9036",
	"#f89b31",
	"#efa72f",
	"#e6b32e",
	"#dcbe30",
	"#d2c934",
	"#c8d43a",
	"#bfde43",
	"#b6e84e",
	"#aff05b",
}

for i, fg in ipairs(gradient) do
	gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
end

wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer({
		highlights = {
			border = "Normal",
			gradient = gradient,
		},

		border = "rounded",
		highlighter = wilder.highlighter_with_gradient({
			wilder.lua_fzy_highlighter(),
		}),
	})
)
