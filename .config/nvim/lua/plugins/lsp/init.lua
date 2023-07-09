require("plugins.lsp.mason")
require("plugins.lsp.handlers").setup()
require("plugins.lsp.null-ls")
require("plugins.lsp.lsp-saga")

local win = require("lspconfig.ui.windows")
win.default_options.border = "rounded"
