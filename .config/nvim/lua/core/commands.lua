vim.api.nvim_create_user_command("CopyBufferPath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("CopyDirectoryPath", function()
	local path = vim.fn.expand("%:p:h")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("RemoveTrailingSpaces", function()
	vim.cmd("% s/\\s\\+$//e")
end, {})

local workspace = require("projections.workspace")
vim.api.nvim_create_user_command("AddWorkspace", function()
	workspace.add(vim.loop.cwd())
end, {})
