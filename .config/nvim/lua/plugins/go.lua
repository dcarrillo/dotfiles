local status_ok, go = pcall(require, "go")
if not status_ok then
	return
end

go.setup({
	icons = { breakpoint = "", currentpos = "🏃" },
	fillstruct = "fillstruct",
	gofmt = "gofumpt",
	lsp_gofumpt = true,
})

vim.cmd("autocmd FileType go nmap <Leader>gf :lua require('go.format').goimport()<CR>")
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
