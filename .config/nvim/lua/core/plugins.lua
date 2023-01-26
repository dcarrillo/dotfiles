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

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

local lazy_opts = {
	ui = {
		border = "rounded",
	},
}

lazy.setup({
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
			})

			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	-- Plugins
	{ "nvim-lua/plenary.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "numToStr/Comment.nvim", version = "v0.*" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "akinsho/bufferline.nvim", version = "v3.*" },
	{ "moll/vim-bbye" },
	{ "nvim-lualine/lualine.nvim" },
	{ "lukas-reineke/indent-blankline.nvim", version = "v2.*" },
	{ "nvim-zh/auto-save.nvim" },
	{ "gelguy/wilder.nvim" },
	{ "romgrk/fzy-lua-native" },
	{ "mg979/vim-visual-multi", version = "v0.*" },
	{ "gnikdroy/projections.nvim" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "ray-x/sad.nvim" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v2.x",
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{ "taybart/b64.nvim" },

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },

	-- Snippets
	{ "L3MON4D3/LuaSnip", version = "v1.*" },
	{ "rafamadriz/friendly-snippets" },

	-- LSP
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "RRethy/vim-illuminate" },
	{ "folke/trouble.nvim" },
	{ "glepnir/lspsaga.nvim" },
	{ "arkav/lualine-lsp-progress" },

	-- Telescope
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	-- Git
	{ "lewis6991/gitsigns.nvim", version = "v0.*" },
	{ "sindrets/diffview.nvim" },
	{ "f-person/git-blame.nvim" },

	-- DAP
	{ "mfussenegger/nvim-dap", version = "0.*" },
	{ "rcarriga/nvim-dap-ui", version = "v2.*" },
	{ "ravenxrz/DAPInstall.nvim" },
	{ "theHamsta/nvim-dap-virtual-text" },

	-- Go
	{ "ray-x/go.nvim" },
	{
		"ray-x/guihua.lua",
		build = "cd lua/fzy && make",

		config = function()
			require("guihua.maps").setup({
				maps = { close_view = "<C-x>" },
			})
		end,
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
}, lazy_opts)
