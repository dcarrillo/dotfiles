local cfg = require("yaml-companion").setup({
	lspconfig = {
		settings = {
			redhat = {
				telemetry = {
					enabled = false,
				},
			},
			-- 	yaml = {
			-- 		schemas = {
			-- 			["https://custom/github-workflow.json"] = "/.github/workflows/*",
			-- 		},
			-- 	},
		},
	},
})

return cfg
