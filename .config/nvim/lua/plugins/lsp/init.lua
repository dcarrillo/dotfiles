local status_ok, win = pcall(require, "lspconfig.ui.windows")
if not status_ok then
	return
end

require("plugins.lsp.mason")
require("plugins.lsp.handlers").setup()
require("plugins.lsp.null-ls")

win.default_options.border = "rounded"