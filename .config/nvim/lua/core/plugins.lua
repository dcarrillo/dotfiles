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

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	-- Plugins
	use({ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" })
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" })
	use({ "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" })
	use({ "numToStr/Comment.nvim", tag = "v0.*" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "2941f0064874b33e93d3a794a8a4e99f5f6ece56" })
	use({ "kyazdani42/nvim-web-devicons", commit = "9061e2d355ecaa2b588b71a35e7a11358a7e51e1" })
	use({ "akinsho/bufferline.nvim", tag = "v2.*" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "edca2b03c724f22bdc310eee1587b1523f31ec7c" })
	use({ "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" })
	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.*" })
	use({ "nvim-zh/auto-save.nvim", commit = "4b59610e1318f8a89501cee9d47a0e8650f0a4d5" })
	use({ "gelguy/wilder.nvim", commit = "679f348dc90d80ff9ba0e7c470c40a4d038dcecf" })
	use({ "romgrk/fzy-lua-native", commit = "085c7d262aa35cc55a8523e8c1618d398bf717a7", run = "make" })
	use({ "mg979/vim-visual-multi", tag = "v0.*" })
	use({ "Shatur/neovim-session-manager", commit = "4005dac93f5cd1257792259ef4df6af0e3afc213" })
	use({ "nvim-treesitter/nvim-treesitter", commit = "8f927a4d50716e534c5845e835625962adf878e1" })
	use({ "ray-x/sad.nvim", commit = "01b7d84f4f73c8963f5933f09e88c833757bc7d8" })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { "MunifTanjim/nui.nvim", commit = "c59bdcfde011b88bfb71b5c4351684cf67bf5f9f" },
	})

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "9fba0cdd05382a427dafaa2b8ebb4aba99126bc0" })
	use({ "EdenEast/nightfox.nvim", commit = "15f3b5837a8d07f45cbe16753fbf13630bc167a3" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "e94d3489311f941788756953df23ca84f83eec95" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "3cf38d9c957e95c397b66f91967758b31be4abe6" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", tag = "v1.*" })
	use({ "rafamadriz/friendly-snippets", commit = "fd16b4d9dc58119eeee57e9915864c4480d591fd" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "2dd9e060f21eecd403736bef07ec83b73341d955" })
	use({ "williamboman/mason.nvim", commit = "c8f00c49d9db168b3b622d31e836d7389cae0761" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "bf8ac1221aed7d61abc646cffb5450b1aca31d39" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "643c67a296711ff40f1a4d1bec232fa20b179b90" })
	use({ "RRethy/vim-illuminate", commit = "0603e75fc4ecde1ee5a1b2fc8106ed6704f34d14" })
	use({ "folke/trouble.nvim", commit = "ed65f84abc4a1e5d8f368d7e02601fc0357ea15e" })
	use({ "simrat39/symbols-outline.nvim", commit = "6a3ed24c5631da7a5d418bced57c16b32af7747c" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "f174a0367b4fc7cb17710d867e25ea792311c418" })
	use({ "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e58c7bbe191297b983a9e7e89420f581369" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90",
		run = "make",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", tag = "v0.5*" })
	use({ "sindrets/diffview.nvim", commit = "a1fbcaa7e1e154cfa793ab44da4a6eb0ae15458d" })
	use({ "f-person/git-blame.nvim", commit = "08e75b7061f4a654ef62b0cac43a9015c87744a2" })

	-- DAP
	use({ "mfussenegger/nvim-dap", tag = "0.3*" })
	use({ "rcarriga/nvim-dap-ui", tag = "v2.*" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })
	use({ "theHamsta/nvim-dap-virtual-text", commit = "2971ce3e89b1711cc26e27f73d3f854b559a77d4" })

	-- Go
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

	-- Markdown
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
