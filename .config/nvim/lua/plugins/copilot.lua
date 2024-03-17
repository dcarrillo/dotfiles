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

local prompts = {
	Spelling = {
		prompt = "/Spelling Please correct any grammar and spelling errors in the following text. Respect the markdown format when provided",
	},
}

require("copilot_cmp").setup()
require("CopilotChat").setup({
	debug = false,
	show_user_selection = false,
	clear_chat_on_new_prompt = true,
	prompts = prompts,
})
