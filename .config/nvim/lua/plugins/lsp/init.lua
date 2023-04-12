require("plugins.lsp.mason")
require("plugins.lsp.handlers").setup()
require("plugins.lsp.null-ls")
require("plugins.lsp.lsp-saga")
require("plugins.lsp.yaml-companion")

local win = require("lspconfig.ui.windows")
win.default_options.border = "rounded"
