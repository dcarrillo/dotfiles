local servers = {
	"ansiblels",
	"bashls",
	"gopls",
	"helm_ls",
	"html",
	"jdtls",
	"jsonls",
	"lua_ls",
	"marksman",
	-- "basedpyright",
	"ruff",
	"terraformls",
	"ty",
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

for _, server in pairs(servers) do
	if server ~= "ty" then
		local opts = {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		}

		server = vim.split(server, "@")[1]

		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
		local config_exists, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
		if config_exists then
			opts = vim.tbl_deep_extend("force", conf_opts, opts)
		end

		vim.lsp.config(server, opts)
	end
end
