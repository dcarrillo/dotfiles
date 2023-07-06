local ufo = require("ufo")

ufo.setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})

local keymap = vim.keymap.set

keymap("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
keymap("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
keymap("n", "zr", ufo.openFoldsExceptKinds, { desc = "Fold less" })
keymap("n", "zm", ufo.closeFoldsWith, { desc = "Fold more" })
keymap("n", "zp", ufo.peekFoldedLinesUnderCursor, { desc = "Peek fold" })
