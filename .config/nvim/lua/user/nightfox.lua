local status_nf_ok, nightfox = pcall(require, "nightfox")
if not status_nf_ok then
	return
end

local palettes = {
	nightfox = {
		bg1 = "#1c1e26",
	},
}

nightfox.setup({ palettes = palettes })
