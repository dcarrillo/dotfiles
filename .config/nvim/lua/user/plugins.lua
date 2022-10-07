local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Plugins
	use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" })
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" })
	use({ "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" })
	use({ "numToStr/Comment.nvim", tag = "v0.*" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" })
	use({ "kyazdani42/nvim-web-devicons", commit = "a8cf88cbdb5c58e2b658e179c4b2aa997479b3da" })
	use({ "akinsho/bufferline.nvim", tag = "v2.*" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "edca2b03c724f22bdc310eee1587b1523f31ec7c" })
	use({ "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" })
	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.*" })
	use({ "Pocco81/auto-save.nvim", commit = "2c7a2943340ee2a36c6a61db812418fca1f57866" })
	use({ "gelguy/wilder.nvim", commit = "679f348dc90d80ff9ba0e7c470c40a4d038dcecf" })
	use({ "romgrk/fzy-lua-native", commit = "085c7d262aa35cc55a8523e8c1618d398bf717a7", run = "make" })
	use({ "mg979/vim-visual-multi", tag = "v0.*" })
	use({ "Shatur/neovim-session-manager", commit = "4005dac93f5cd1257792259ef4df6af0e3afc213" })
	use({ "nvim-treesitter/nvim-treesitter", commit = "5d11dfc27849e3d7435c32dbd8ea9be35bcd990b" })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { "MunifTanjim/nui.nvim", commit = "4715f6092443f0b8fb9a3bcb0cfd03202bb03477" },
	})

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "fd9105c9487996aa2269992b72a6fea7504688e4" })
	use({ "EdenEast/nightfox.nvim", commit = "59c3dbcec362eff7794f1cb576d56fd8a3f2c8bb" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "0e436ee23abc6c3fe5f3600145d2a413703e7272" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", tag = "v1.*" })
	use({ "rafamadriz/friendly-snippets", commit = "6cd7469403fd06a3840a1065728d1affe1c23ec8" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "9d4b8d393aad0e6e9227e2d67629aa99e56b994a" })
	use({ "williamboman/nvim-lsp-installer", commit = "23820a878a5c2415bfd3b971d1fe3c79e4dd6763" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "6a98411e70fad6928f7311eeade4b1753cb83524" })
	use({ "RRethy/vim-illuminate", commit = "0603e75fc4ecde1ee5a1b2fc8106ed6704f34d14" })
	use({ "folke/trouble.nvim", commit = "929315ea5f146f1ce0e784c76c943ece6f36d786" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "76ea9a898d3307244dce3573392dcf2cc38f340f" })
	use({ "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e58c7bbe191297b983a9e7e89420f581369" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90",
		run = "make",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", tag = "v0.5*" })
	use({ "sindrets/diffview.nvim", commit = "7c149a4df943c05846d3f552b89b47df50f009c9" })
	use({ "f-person/git-blame.nvim", commit = "08e75b7061f4a654ef62b0cac43a9015c87744a2" })

	-- DAP
	use({ "mfussenegger/nvim-dap", tag = "0.3*" })
	use({ "rcarriga/nvim-dap-ui", tag = "v2.*" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })
	use({ "theHamsta/nvim-dap-virtual-text", commit = "2971ce3e89b1711cc26e27f73d3f854b559a77d4" })

	-- golang
	use({ "ray-x/go.nvim", commit = "1aef2d60bd220a8d58a0b5fed6af696b6244ce1d" })
	use({
		"ray-x/guihua.lua",
		commit = "2fce8a8b462cf6599d9422efb157773126e1c7ce",
		run = "cd lua/fzy && make",

		config = function()
			require("guihua.maps").setup({
				maps = { close_view = "<C-x>" },
			})
		end,
	})

	-- markdown
	use({ "mzlogin/vim-markdown-toc", commit = "7ec05df27b4922830ace2246de36ac7e53bea1db" })
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
