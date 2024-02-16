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

local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	-- Text related prompts
	Spelling = "Please correct any grammar and spelling errors in the following text. Respect the markdown format when provided",
	Wording = "Please improve the grammar and wording of the following text. Respect the markdown format when provided",
}
require("CopilotChat").setup({
	show_help = "yes",
	debug = false,
	disable_extra_info = "yes",
	prompts = prompts,
})
