return {
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				shadow = true,
			},
			staticcheck = true,
			directoryFilters = { "-.git" },
			semanticTokens = true,
		},
	},
}
