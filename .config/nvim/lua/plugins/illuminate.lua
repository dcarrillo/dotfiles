local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
	return
end

illuminate.configure({
	delay = 200,
	filetypes_denylist = {
		"neo-tree",
		"packer",
		"Trouble",
		"TelescopePrompt",
	},
})
