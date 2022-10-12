local status_ok, win = pcall(require, "lspconfig.ui.windows")
if not status_ok then
	return
end

require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

win.default_options.border = 'rounded'
