local status_ok, align = pcall(require, "mini.align")
if not status_ok then
	return
end

align.setup({})
