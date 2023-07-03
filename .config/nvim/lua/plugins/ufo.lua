require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})

local keymap = vim.keymap.set
-- Code Folding
-- keymap("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
-- keymap("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
keymap("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Fold less" })
keymap("n", "zm", require("ufo").closeFoldsWith, { desc = "Fold more" })
keymap("n", "zp", require("ufo").peekFoldedLinesUnderCursor, { desc = "Peek fold" })
