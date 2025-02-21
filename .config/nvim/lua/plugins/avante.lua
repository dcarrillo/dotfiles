require("avante").setup({
	-- provider = "copilot",
	provider = "claude",
	claude = {
		api_key_name = "cmd:secret-tool lookup description ANTHROPIC_API_KEY",
	},
	web_search_engine = {
		provider = "tavily",
	},
	hints = { enabled = false },
})
