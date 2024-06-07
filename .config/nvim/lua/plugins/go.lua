require("go").setup({
	icons = { breakpoint = "", currentpos = "🏃" },
	fillstruct = "fillstruct",
	gofmt = "gofumpt",
	diagnostic = false,
})

require("guihua.maps").setup({
	maps = { close_view = "<C-x>" },
})

vim.cmd("autocmd FileType go nmap <Leader>gf :lua require('go.format').goimport()<CR>")

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

