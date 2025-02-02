local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazy_opts = {
	ui = {
		border = "rounded",
	},
}

require("lazy").setup({
	-- Colorschemes
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "moon",
				styles = {
					sidebars = "normal",
					floats = "normal",
				},
				on_colors = function(colors)
					colors.error = "#ff966c"
				end,
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		config = function()
			local options = {
				darken = {
					floats = false,
					sidebars = {
						enable = false,
					},
				},
				styles = {
					comments = "italic",
					keywords = "italic",
				},
			}
			local specs = {
				github_dark_dimmed = {
					syntax = {
						builtin1 = "#96d0ff",
					},
					diagnostic = {
						error = "#dd6861",
					},
				},
			}
			require("github-theme").setup({ options = options, specs = specs })
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		config = function()
			require("rose-pine").setup({
				palette = {
					moon = {
						gold = "#faf4ed",
					},
				},
			})

			vim.cmd("colorscheme rose-pine-moon")
		end,
	},

	-- Plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "echasnovski/mini.starter", lazy = "VimEnter", version = "*" },
	{ "echasnovski/mini.animate", version = "*" },
	{ "windwp/nvim-autopairs" },
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "akinsho/bufferline.nvim", event = "VeryLazy", version = "v4.*" },
	{ "moll/vim-bbye" },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
	{ "lukas-reineke/indent-blankline.nvim", event = "BufReadPost", main = "ibl" },
	{ "nvim-zh/auto-save.nvim", event = "BufReadPost" },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{ "romgrk/fzy-lua-native" },
	{ "mg979/vim-visual-multi" },
	{
		"coffebar/neovim-project",
		dependencies = {
			{ "Shatur/neovim-session-manager" },
		},
		event = "VeryLazy",
	},
	{ "nvim-treesitter/nvim-treesitter", event = "BufReadPost" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v3.x",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{ "taybart/b64.nvim", event = "VeryLazy" },
	{ "tenxsoydev/karen-yank.nvim", event = "VeryLazy", config = true },
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
		end,
	},
	{
		"knubie/vim-kitty-navigator",
		build = "cp ./*.py ~/.config/kitty/",
	},
	{
		"MagicDuck/grug-far.nvim",
		event = "VeryLazy",
	},

	-- cmp plugins
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	-- LSP
	{ "neovim/nvim-lspconfig", event = "BufReadPre" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "nvimtools/none-ls.nvim", event = "BufReadPre" },
	{ "RRethy/vim-illuminate", event = "BufReadPost" },
	{ "folke/trouble.nvim" },
	{ "glepnir/lspsaga.nvim", event = "BufRead" },
	{ "arkav/lualine-lsp-progress" },
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	},

	-- Telescope
	{ "nvim-telescope/telescope.nvim", cmd = "Telescope" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Git
	{ "lewis6991/gitsigns.nvim", event = "BufReadPre" },
	{ "sindrets/diffview.nvim" },
	{ "f-person/git-blame.nvim" },

	-- YAML
	{
		"someone-stole-my-name/yaml-companion.nvim",
		ft = { "yaml" },
		opts = {
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
		},
		config = function(_, opts)
			local cfg = require("yaml-companion").setup(opts)
			require("lspconfig")["yamlls"].setup(cfg)
		end,
	},

	-- DAP
	{ "mfussenegger/nvim-dap", event = "VeryLazy", version = "0.*" },
	{ "rcarriga/nvim-dap-ui", event = "VeryLazy", version = "v4.*" },
	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap-python" },

	-- Python
	{
		"linux-cultist/venv-selector.nvim",
		lazy = false,
		branch = "regexp",
		config = function()
			require("venv-selector").setup({
				dap_enabled = true,
			})
		end,
	},

	-- Go
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			build = "cd lua/fzy && make",
		},
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
	},

	-- Testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
			"nvim-neotest/nvim-nio",
			"antoinemadec/FixCursorHold.nvim",
		},
	},

	-- Typescript
	{
		"pmizio/typescript-tools.nvim",
	},

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown",
		version = "v7",
	},

	-- Copilot
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		opts = {
			provider = "copilot",
			auto_suggestions_provider = "claude",
		},
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{ "zbirenbaum/copilot-cmp" },
	{ "AndreM222/copilot-lualine" },
	{
		"copilotc-nvim/copilotchat.nvim",
		branch = "main",
		event = "VeryLazy",
	},

	-- Folding
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{
								text = {
									builtin.foldfunc,
								},
								click = "v:lua.ScFa",
							},
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
	},
	{ "towolf/vim-helm", ft = "helm" },
	{ "robbles/logstash.vim" },
}, lazy_opts)
