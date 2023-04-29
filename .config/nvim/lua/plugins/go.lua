require("go").setup({
	icons = { breakpoint = "", currentpos = "🏃" },
	fillstruct = "fillstruct",
	gofmt = "gofumpt",
	lsp_gofumpt = true,
})

require("guihua.maps").setup({
	maps = { close_view = "<C-x>" },
})

vim.cmd("autocmd FileType go nmap <Leader>gf :lua require('go.format').goimport()<CR>")
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
