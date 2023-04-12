local dap = require("dap")
local dapui = require("dapui")

require("dap-install").config("python", {})
dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.25 },
				"watches",
				"stacks",
				"breakpoints",
			},
			size = 50, -- columns
			position = "left",
		},
		{
			elements = {
				"repl",
				-- "console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
