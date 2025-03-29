require("plugins.lsp.mason")
require("plugins.lsp.none-ls")
require("plugins.lsp.conform")
require("plugins.lsp.lsp-saga")

local win = require("lspconfig.ui.windows")
win.default_options.border = "rounded"

local config = {
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}
vim.diagnostic.config(config)
