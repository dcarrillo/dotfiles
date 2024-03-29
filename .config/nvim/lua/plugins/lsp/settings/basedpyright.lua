return {
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				autoImportCompletions = true,
				diagnosticsMode = "openFilesOnly", -- workspace, openFilesOnly
				diagnosticSeverityOverrides = {
					typeCheckingMode = "standard", -- off, basic, standard, strict, all
					reportAny = false,
					reportDeprecated = "information",
					reportMissingTypeStubs = "information",
					reportUnknownMemberType = "information",
					reportUnknownVariableType = "information",
				},
			},
		},
	},
}
