return require("schema-companion").setup_client(
	require("schema-companion").adapters.yamlls.setup({
		sources = {
			require("schema-companion").sources.matchers.kubernetes.setup({ version = "master" }),
			require("schema-companion").sources.lsp.setup(),
			require("schema-companion").sources.schemas.setup({
				{
					name = "Kubernetes master",
					uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
				},
			}),
		},
	}),
	{
		-- Have to add this for yamlls to understand that we support line folding
		capabilities = {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		},
		settings = {
			redhat = { telemetry = { enabled = false } },
		},
	}
)
