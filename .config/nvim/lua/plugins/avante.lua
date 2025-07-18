require("avante").setup({
	provider = "copilot",
	providers = {
		copilot = {
			model = "claude-3.7-sonnet",
			-- model = "gpt-4.1",
			timeout = 120000,
		},
	},
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
	-- disabled_tools = {
	-- 	"list_files",
	-- 	"search_files",
	-- 	"read_file",
	-- 	"create_file",
	-- 	"rename_file",
	-- 	"delete_file",
	-- 	"create_dir",
	-- 	"rename_dir",
	-- 	"delete_dir",
	-- 	"bash",
	-- },
})
