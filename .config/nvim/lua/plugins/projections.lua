local status_ok, projections = pcall(require, "projections")
if not status_ok then
	return
end

projections.setup({
	store_hooks = {
		pre = function()
			-- Close neo-tree before storing sessions
			if pcall(require, "neo-tree") then
				vim.cmd([[Neotree action=close]])
			end
		end,
	},
})
