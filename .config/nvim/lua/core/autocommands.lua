vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
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

--  Disable illuminate on very large files
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})

-- Autostore session on VimExit
local session = require("projections.session")
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	callback = function()
		session.store(vim.loop.cwd())
	end,
})

-- If vim was started with arguments, do nothing
-- If in some project's root, attempt to restore that project's session
-- If not, restore last session
-- If no sessions, do nothing
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		if vim.fn.argc() ~= 0 then
			return
		end
		local session_info = session.info(vim.loop.cwd())
		if session_info == nil then
			session.restore_latest()
		else
			session.restore(vim.loop.cwd())
		end
	end,
	desc = "Restore last session automatically",
})
