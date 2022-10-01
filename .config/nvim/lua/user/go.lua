local status_ok, go = pcall(require, "go")
if not status_ok then
	return
end

vim.cmd("autocmd FileType go nmap <Leader>gf :lua require('go.format').goimport()<CR>")
go.setup({
	icons = { breakpoint = "", currentpos = "🏃" },
})
