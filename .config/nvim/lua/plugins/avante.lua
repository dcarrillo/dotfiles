require("avante").setup({
	provider = "copilot",
	copilot = { model = "claude-3.7-sonnet" },
	-- provider = "claude",
	-- claude = {
	-- 	api_key_name = "cmd:secret-tool lookup description ANTHROPIC_API_KEY",
	-- },
	web_search_engine = {
		provider = "tavily",
	},
	hints = { enabled = false },
})
