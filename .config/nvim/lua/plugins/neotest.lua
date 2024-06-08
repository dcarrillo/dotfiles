local neotest_ns = vim.api.nvim_create_namespace("neotest")

vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			return message
		end,
	},
}, neotest_ns)

vim.api.nvim_create_user_command("CopyDirectoryPath", function()
	local path = vim.fn.expand("%:p:h")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-go")({
			recursive_run = true,
			experimental = {
				test_table = true,
			},
			args = { "-count=1" },
		}),
		require("neotest-python")({}),
	},
})

vim.api.nvim_create_user_command("RunTest", function()
	neotest.run.run()
end, {})

vim.api.nvim_create_user_command("DebugTest", function()
	neotest.run.run({ strategy = "dap" })
end, {})

vim.api.nvim_create_user_command("RunTestFile", function()
	neotest.run.run(vim.fn.expand("%"))
end, {})
