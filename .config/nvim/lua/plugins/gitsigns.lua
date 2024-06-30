require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "󰦺" },
		topdelete = { text = "󰦺" },
		changedelete = { text = "│" },
		untracked = { text = "┆" },
	},
	preview_config = {
		border = "rounded",
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>hp", gs.preview_hunk)
		map("n", "<leader>hR", gs.reset_buffer)
		map("n", "<leader>hd", gs.diffthis)
		map("n", "<leader>hj", gs.next_hunk)
		map("n", "<leader>hk", gs.prev_hunk)
	end,
})
