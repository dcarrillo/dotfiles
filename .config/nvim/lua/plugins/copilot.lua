require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
	filetypes = {
		javascript = true,
		typescript = true,
		go = true,
		lua = true,
		python = true,
		sh = true,
		yaml = true,
		json = true,
		["*"] = false,
	},
})

require("copilot_cmp").setup()
