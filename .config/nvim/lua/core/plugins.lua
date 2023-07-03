local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
					colors.gitSigns.add = "#c3e88d"
					colors.gitSigns.change = "#779be9"
				end,
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		version = "v1.0.x",
		config = function()
			local options = {
				darken = {
					floats = false,
					sidebars = {
						enable = false,
						list = {},
					},
				},
			}
			local specs = {
				github_dark_dimmed = {
					syntax = {
						keyword = "yellow.base",
					},
					diagnostic = {
						error = "#dd6861",
					},
				},
			}
			require("github-theme").setup({ options = options, specs = specs })
			vim.cmd("colorscheme github_dark_dimmed")
		end,
	},

	-- Plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "echasnovski/mini.starter", lazy = "VimEnter", version = "*" },
	{ "windwp/nvim-autopairs" },
	{ "numToStr/Comment.nvim", version = "v0.*" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "akinsho/bufferline.nvim", event = "VeryLazy", version = "v3.*" },
	{ "moll/vim-bbye" },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
	{ "lukas-reineke/indent-blankline.nvim", event = "BufReadPost", version = "v2.*" },
	{ "nvim-zh/auto-save.nvim", event = "BufReadPost" },
	{ "gelguy/wilder.nvim" },
	{ "romgrk/fzy-lua-native" },
	{ "mg979/vim-visual-multi", version = "v0.*" },
	{ "gnikdroy/projections.nvim", branch = "pre_release" },
	{ "nvim-treesitter/nvim-treesitter", event = "BufReadPost" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v2.x",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{ "taybart/b64.nvim", event = "VeryLazy" },
	{ "echasnovski/mini.align", event = "VeryLazy", version = "*" },
	{ "tenxsoydev/karen-yank.nvim", event = "VeryLazy", config = true },
	{
		"ggandor/leap.nvim",
		version = "*",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"knubie/vim-kitty-navigator",
		version = "*",
		build = "cp ./*.py ~/.config/kitty/",
	},

	-- cmp plugins
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{ "jcdickinson/codeium.nvim" },

	-- Snippets
	{ "L3MON4D3/LuaSnip", version = "v1.*" },
	{ "rafamadriz/friendly-snippets" },

	-- LSP
	{ "neovim/nvim-lspconfig", event = "BufReadPre" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim", event = "BufReadPre" },
	{ "RRethy/vim-illuminate", event = "BufReadPost" },
	{ "folke/trouble.nvim", cmd = { "TroubleToggle", "Trouble" } },
	{ "glepnir/lspsaga.nvim", event = "BufRead" },
	{ "arkav/lualine-lsp-progress" },
	{ "someone-stole-my-name/yaml-companion.nvim", event = "BufRead" },

	-- Telescope
	{ "nvim-telescope/telescope.nvim", cmd = "Telescope" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Git
	{ "lewis6991/gitsigns.nvim", event = "BufReadPre", version = "v0.*" },
	{ "sindrets/diffview.nvim" },
	{ "f-person/git-blame.nvim" },

	-- DAP
	{ "mfussenegger/nvim-dap", event = "VeryLazy", version = "0.*" },
	{ "rcarriga/nvim-dap-ui", event = "VeryLazy", version = "v2.*" },
	{ "ravenxrz/DAPInstall.nvim", event = "VeryLazy" },
	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },

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

	-- Markdown
	{ "mzlogin/vim-markdown-toc" },
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
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
}, lazy_opts)
