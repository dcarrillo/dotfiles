local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local revive_conf = vim.fn.findfile(os.getenv("HOME") .. "/.revive.toml")
local revive_args = { "-formatter", "json", "./..." }
if revive_conf then
	revive_args = { "-formatter", "json", "-config", revive_conf, "./..." }
end

null_ls.setup({
	debug = false,
	sources = {
		formatting.black.with({
			extra_args = { "--fast" },
		}),
		formatting.stylua,
		formatting.prettier,
		diagnostics.hadolint,
		diagnostics.markdownlint,
		diagnostics.revive.with({
			args = revive_args,
		}),
	},
})
