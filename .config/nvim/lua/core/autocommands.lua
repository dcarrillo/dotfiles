-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 250 })
	end,
})

-- Set expandtab=true in several file types
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "go", "makefile", "lua" },
	callback = function()
		vim.opt_local.expandtab = false
	end,
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo" },
	callback = function()
		vim.cmd([[
			nnoremap <silent> <buffer> q :close<CR>
			set nobuflisted
		]])
	end,
})

-- Disable illuminate on very large files
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})

-- Ensure terraform files use hcl LSP
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.tf" },
	callback = function()
		vim.cmd([[
			set filetype=hcl
		]])
	end,
})
