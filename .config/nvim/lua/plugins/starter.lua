local starter = require("mini.starter")
local pad = string.rep(" ", 4)
local new_section = function(name, action, section)
	return { name = name, action = action, section = pad .. section }
end

local logo = table.concat({
	"",
	"",
	"",
	"",
	"███╗  ██╗██╗   ██╗██╗███╗   ███╗",
	"████╗ ██║██║   ██║██║████╗ ████║",
	"██╔██╗██║╚██╗ ██╔╝██║██╔████╔██║",
	"██║╚████║ ╚████╔╝ ██║██║╚██╔╝██║",
	"██║ ╚███║  ╚██╔╝  ██║██║ ╚═╝ ██║",
	"╚═╝  ╚══╝   ╚═╝   ╚═╝╚═╝     ╚═╝",
}, "\n")

starter.setup({
	evaluate_single = true,
	header = logo,
	footer = "",
	items = {
		new_section("Projects", "Telescope neovim-project discover", "Telescope"),
		new_section("Recent files", "Telescope oldfiles", "Telescope"),
		new_section("New file", "ene | startinsert", "Built-in"),
		new_section("Quit", "qa", "Built-in"),
		new_section("Lazy", "Lazy", "Config"),
		new_section("Mason", "Mason", "Config"),
		new_section("Tree-sitter", "TSUpdate", "Config"),
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(pad .. "  ", false),
		starter.gen_hook.aligning("center", "top"),
	},
})
