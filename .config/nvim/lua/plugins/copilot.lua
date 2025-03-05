require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
	filetypes = {
		dockerfile = true,
		go = true,
		hcl = true,
		helm = true,
		javascript = true,
		json = true,
		lua = true,
		make = true,
		markdown = true,
		python = true,
		sh = true,
		typescript = true,
		yaml = true,
		["*"] = false,
	},
})

local prompts = {
	Spelling = {
		system_prompt = "You are a technical writer. You have a deep understanding of both the English and the Spanish languages. You can effectively communicate complex ideas and concepts in a way everyone easily understands. You have a keen eye for detail and can pick up on subtle nuances in language that others may miss. You are also skilled at translating written or spoken content from one language to another, ensuring that the meaning and tone of the original message are preserved.",
		prompt = "Correct any grammar and spelling errors in the following text. Respect the markdown format when provided",
	},
}

require("CopilotChat").setup({
	highlight_headers = false,
	-- separator = "———",
	error_header = "> [!ERROR] Error",
	debug = false,
	show_user_selection = false,
	clear_chat_on_new_prompt = false,
	prompts = prompts,
	model = "claude-3.7-sonnet-thought",
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "copilot-chat",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
	end,
})
