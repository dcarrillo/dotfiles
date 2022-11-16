local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
	return
end

diffview.setup({
	view = {
		merge_tool = {
			layout = "diff3_mixed",
		},
	},
})

vim.opt.fillchars = "diff: "
