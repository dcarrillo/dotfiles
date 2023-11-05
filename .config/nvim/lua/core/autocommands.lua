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

-- Ensure terraform files use hcl LSP
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.tf" },
	callback = function()
		vim.cmd([[
			set filetype=hcl
		]])
	end,
})

-- Disable some plugins on very large files
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	callback = function(args)
		local highlighter = require("vim.treesitter.highlighter")
		local ts_was_active = highlighter.active[args.buf]
		local file_size = vim.fn.getfsize(args.file)
		if file_size > 1024 * 1024 then
			vim.cmd("TSBufDisable highlight")
			vim.cmd("syntax off")
			vim.cmd("syntax clear")
			vim.cmd("IlluminatePauseBuf")
			vim.cmd("NoMatchParen")
			vim.cmd("UfoDisable")
			vim.cmd("IBLDisable")
			vim.cmd("LspStop")
			if ts_was_active then
				vim.notify("File larger than 1MB; syntax highlighting and heavy CPU use plugins are turned off.")
			end
		end
	end,
})
