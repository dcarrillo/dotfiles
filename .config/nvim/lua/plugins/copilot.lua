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
		system_prompt =
		"You are a technical writer. You have a deep understanding of both the English and the Spanish languages. You can effectively communicate complex ideas and concepts in a way everyone easily understands. You have a keen eye for detail and can pick up on subtle nuances in language that others may miss. You are also skilled at translating written or spoken content from one language to another, ensuring that the meaning and tone of the original message are preserved.",
		prompt =
		"Correct any grammar and spelling errors in the following text. Respect the markdown format when provided",
	},
}

require("copilot_cmp").setup()
require("CopilotChat").setup({
	debug = false,
	show_user_selection = false,
	clear_chat_on_new_prompt = true,
	prompts = prompts,
})
