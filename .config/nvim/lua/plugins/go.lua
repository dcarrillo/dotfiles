require("go").setup({
	icons = { breakpoint = "", currentpos = "🏃" },
	fillstruct = "fillstruct",
	gofmt = "gofumpt",
	diagnostic = false,
})

require("guihua.maps").setup({
	maps = { close_view = "<C-x>" },
})
