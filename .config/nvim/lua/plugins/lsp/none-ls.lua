local none_ls = require("null-ls")
-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = none_ls.builtins.formatting
-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = none_ls.builtins.diagnostics

local revive_conf = vim.fn.findfile(os.getenv("HOME") .. "/.revive.toml")
local revive_args = { "-formatter", "json", "./..." }
if revive_conf then
	revive_args = { "-formatter", "json", "-config", revive_conf, "./..." }
end

none_ls.setup({
	debug = false,
	sources = {
		formatting.black.with({
			extra_args = { "--fast", "--line-length", "100" },
		}),
		formatting.stylua,
		formatting.prettier,
		diagnostics.hadolint,
		diagnostics.markdownlint,
		diagnostics.revive.with({
			args = revive_args,
		}),
		diagnostics.cfn_lint,
	},
})
