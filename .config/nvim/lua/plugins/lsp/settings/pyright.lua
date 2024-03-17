return {
	cmd = { "/home/dani/.local/pipx/venvs/basedpyright/bin/basedpyright-langserver", "--stdio" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
}
