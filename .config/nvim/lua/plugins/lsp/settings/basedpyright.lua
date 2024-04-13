return {
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				autoImportCompletions = true,
				diagnosticsMode = "openFilesOnly", -- workspace, openFilesOnly
				typeCheckingMode = "standard", -- off, basic, standard, strict, all
				diagnosticSeverityOverrides = {
					-- reportAny = true
					reportOptionalIterable = "warning",
					reportArgumentType = "warning",
				},
			},
		},
	},
}
