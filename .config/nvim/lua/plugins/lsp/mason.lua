local servers = {
	"ansiblels",
	"bashls",
	"gopls",
	"html",
	"jdtls",
	"jsonls",
	"lua_ls",
	"pyright",
	"ruff_lsp",
	"terraformls",
	"yamlls",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig = require("lspconfig")
for _, server in pairs(servers) do
	if server ~= "yamlls" then
		local opts = {
			on_attach = require("plugins.lsp.handlers").on_attach,
			capabilities = require("plugins.lsp.handlers").capabilities,
		}

		server = vim.split(server, "@")[1]

		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		local config_exists, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
		if config_exists then
			opts = vim.tbl_deep_extend("force", conf_opts, opts)
		end

		lspconfig[server].setup(opts)
	end
end
