require("avante").setup({
	provider = "copilot",
	copilot = {
		model = "claude-3.7-sonnet",
		timeout = 120000,
	},
	-- provider = "claude",
	-- claude = {
	-- 	api_key_name = "cmd:secret-tool lookup description ANTHROPIC_API_KEY",
	-- },
	-- web_search_engine = {
	-- 	provider = "tavily",
	-- },
	hints = { enabled = false },
	behaviour = {
		enable_claude_text_editor_tool_mode = true,
	},

	system_prompt = function()
		local hub = require("mcphub").get_hub_instance()
		return hub and hub:get_active_servers_prompt() or ""
	end,
	custom_tools = function()
		return {
			require("mcphub.extensions.avante").mcp_tool(),
		}
	end,

	-- using the MCP server
	disabled_tools = {
		"list_files",
		"search_files",
		"read_file",
		"create_file",
		"rename_file",
		"delete_file",
		"create_dir",
		"rename_dir",
		"delete_dir",
		"bash",
	},
})
