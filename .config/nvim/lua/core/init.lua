require("core.options")
require("core.colorscheme")

vim.defer_fn(function()
	require("core.keymaps")
	require("core.plugins")
	require("core.autocommands")
	require("core.commands")
end, 0)
