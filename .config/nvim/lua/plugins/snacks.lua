require("snacks").setup({
	animate = {},
	bigfile = {},
	explorer = {},
	picker = {
		sources = {
			explorer = {
				hidden = true,
				ignored = true,
			},
		},
		actions = {
			opencode_send = function(...)
				return require("opencode").snacks_picker_send(...)
			end,
		},
		win = {
			input = {
				keys = {
					["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
				},
			},
		},
	},
	indent = {
		indent = { char = "▏" },
		scope = { char = "▏" },
	},
	scroll = {},
	gitbrowse = {},
	image = {},
	dashboard = {
		sections = {
			{ section = "header" },

			{ icon = "", desc = "Projects", action = ":NeovimProjectDiscover history", key = "p", padding = 1 },

			{ icon = "", key = "n", desc = "New File", action = ":ene | startinsert" },
			{
				icon = "",
				desc = "Recent Files",
				action = ":lua Snacks.dashboard.pick('oldfiles')",
				key = "r",
			},
			{ icon = "", key = "q", desc = "Quit", action = ":qa", padding = 1 },

			{ icon = "", title = "Config" },
			{
				icon = "󰒲",
				desc = "Lazy",
				action = ":Lazy",
				enabled = package.loaded.lazy ~= nil,
				key = "l",
				indent = 2,
			},
			{ icon = "", desc = "Mason", action = ":Mason", key = "m", indent = 2 },
			{ icon = "", desc = "Tree-sitter", action = ":TSManager", key = "t", indent = 2, padding = 2 },

			{ section = "startup" },
		},
	},
})
