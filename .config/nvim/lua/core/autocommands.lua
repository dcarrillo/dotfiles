-- Highlight Yanked Text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Set expandtab=true in several file types
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "makefile", "lua" },
	callback = function()
		vim.opt_local.expandtab = false
	end,
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
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

-- Set hcl and helm indentation to 2
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "hcl", "helm" },
	command = "setlocal shiftwidth=2 tabstop=2",
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
