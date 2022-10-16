local status_ok, sad = pcall(require, "sad")
if not status_ok then
	return
end

sad.setup({
	diff = "delta",
	ls_file = "fd",
	exact = false,
	vsplit = false,
	height_ratio = 0.7,
	width_ratio = 0.7,
})
