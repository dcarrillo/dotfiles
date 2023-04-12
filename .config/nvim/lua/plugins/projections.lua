require("projections").setup({
	store_hooks = {
		pre = function()
			-- Close neo-tree before storing sessions
			vim.cmd([[Neotree action=close]])
		end,
	},
})
