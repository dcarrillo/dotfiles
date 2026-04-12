require("avante").setup({
	provider = "copilot",
	providers = {
		copilot = {
			-- model = "gpt-4.1",
			-- model = "claude-3.7-sonnet",
			-- model = "claude-sonnet-4",
			model = "claude-sonnet-4.5",
			-- model = "claude-opus-4.6",
			timeout = 120000,
		},
	},
	-- web_search_engine = {
	-- 	provider = "tavily",
	-- },
	selection = {
		enabled = false,
		-- hint_display = "delayed",
	},
	behaviour = {
		enable_claude_text_editor_tool_mode = true,
	},
})
