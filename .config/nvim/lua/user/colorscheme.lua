local colorscheme = "tokyonight"

-- if colorscheme == "nightfox" then
-- 	local status_nf_ok, nightfox = pcall(require, "nightfox")
-- 	if not status_nf_ok then
-- 		return
-- 	end
--
-- 	local palettes = {
-- 		nightfox = {
-- 			bg1 = "#24283b",
-- 		},
-- 	}
--
-- 	nightfox.setup({ palettes = palettes })
-- end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end
