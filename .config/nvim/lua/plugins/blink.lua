require("blink.cmp").setup({
	-- disable completion for certain filetypes
	enabled = function()
		return not vim.tbl_contains({ "sagarename", "DressingInput", "AvanteInput" }, vim.bo.filetype)
			and vim.bo.buftype ~= "prompt"
			and vim.b.completion ~= false
	end,

	appearance = {
		use_nvim_cmp_as_default = false,
	},
	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "single" },
		},
		menu = {
			-- don't show completion menu automatically when searching
			auto_show = function(ctx)
				return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
			end,

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
	signature = {
		window = {
			border = "single",
		},
	},
	sources = {
		default = { "lsp", "path", "buffer", "copilot" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
				opts = {
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
