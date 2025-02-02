require("blink.cmp").setup({
	appearance = {
		use_nvim_cmp_as_default = false,
	},
	completion = {
		accept = {
			auto_brackets = {
				enabled = false,
			},
		},
		menu = {
			border = "single",
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind", gap = 1 },
				},
			},
		},
	},
	signature = { window = { border = "single" } },
	sources = {
		default = { "lsp", "path", "buffer", "copilot" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
				opts = {
					kind = "IA",
					max_completions = 3,
				},
			},
		},
	},

	keymap = {
		preset = "enter",
		["<C-q>"] = { "hide", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
	},
})
