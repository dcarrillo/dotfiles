require("conform").setup({
	formatters_by_ft = {
		go = { "goimports", "gofumpt" },
		javascript = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		python = { "isort", "black" },
		typescript = { "prettier" },
		yaml = { "prettier" },
	},
	formatters = {
		{
			command = "black",
			args = { "--line-length", "100" },
		},
	},
	format_on_save = function(bufnr)
		local filetypes = { "go", "typescript", "lua" }
		if not vim.tbl_contains(filetypes, vim.bo[bufnr].filetype) then
			return
		end

		return { timeout_ms = 500, lsp_fallback = false }
	end,
})
