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
	use({ "wbthomason/packer.nvim", commit = "1d0cf98a561f7fd654c970c49f917d74fafe1530" })
	use({ "nvim-lua/plenary.nvim", commit = "1c7e3e6b0f4dd5a174fcea9fda8a4d7de593b826" })
	use({ "windwp/nvim-autopairs", commit = "f00eb3b766c370cb34fdabc29c760338ba9e4c6c" })
	use({ "numToStr/Comment.nvim", tag = "v0.*" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "4a42b30376c1bd625ab5016c2079631d531d797a" })
	use({ "kyazdani42/nvim-web-devicons", commit = "6c38926351372ea87034dec26182b62c835ff3bc" })
	use({ "akinsho/bufferline.nvim", tag = "v3.*" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "0050b308552e45f7128f399886c86afefc3eb988" })
	use({ "lewis6991/impatient.nvim", commit = "c90e273f7b8c50a02f956c24ce4804a47f18162e" })
	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.*" })
	use({ "nvim-zh/auto-save.nvim", commit = "4b59610e1318f8a89501cee9d47a0e8650f0a4d5" })
	use({ "gelguy/wilder.nvim", commit = "679f348dc90d80ff9ba0e7c470c40a4d038dcecf" })
	use({ "romgrk/fzy-lua-native", commit = "085c7d262aa35cc55a8523e8c1618d398bf717a7", run = "make" })
	use({ "mg979/vim-visual-multi", tag = "v0.*" })
	use({ "gnikdroy/projections.nvim", commit = "6820ad90343b5ec78f236bbe0e13d9c8078a0c48" })
	use({ "nvim-treesitter/nvim-treesitter", commit = "5ac2c92060ea84158285c9e314c13256fe6f3ce9" })
	use({ "ray-x/sad.nvim", commit = "e8ab74c7a506f96a823527bfa78a66681483120b" })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { "MunifTanjim/nui.nvim", commit = "257da38029d3859ed111804f9d4e95b0fa993a31" },
	})
	use({ "taybart/b64.nvim", commit = "12dde6ebc3035f010833f513cfbd9abad92b28b3" })

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "73671f5dd48a577e753def35b410ef1157d6560b" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "11a95792a5be0f5a40bab5fc5b670e5b1399a939" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", tag = "v1.*" })
	use({ "rafamadriz/friendly-snippets", commit = "7ab483b355613ef4f74189c7789278d765724d12" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "ed88435764d8b00442e66d39ec3d9c360e560783" })
	use({ "williamboman/mason.nvim", commit = "8529daa38242091d579ed24f28b35c8b80928e8a" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "43c7f402cb9822b61b5dc05bf0b385928df256a6" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "915558963709ea17c5aa246ca1c9786bfee6ddb4" })
	use({ "RRethy/vim-illuminate", commit = "da80f3877896adcf77f59fb0bf74e9601615d372" })
	use({ "folke/trouble.nvim", commit = "83ec606e7065adf134d17f4af6bae510e3c491c1" })
	use({ "glepnir/lspsaga.nvim", commit = "0dc830c25926bfd86a281d8fbd19af89518639d5" })
	use({ "arkav/lualine-lsp-progress", commit = "56842d097245a08d77912edf5f2a69ba29f275d7" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "b69b33eded07341253bc1f0b4ae6bbc5c411a2ab" })
	use({ "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e58c7bbe191297b983a9e7e89420f581369" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		commit = "fab3e2212e206f4f8b3bbaa656e129443c9b802e",
		run = "make",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", tag = "v0.*" })
	use({ "sindrets/diffview.nvim", commit = "0987307b6e3488b14e07d1bd728b747122f10efd" })
	use({ "f-person/git-blame.nvim", commit = "746aed33ccdfe1e41f8b7d5683052337f1b20f01" })

	-- DAP
	use({ "mfussenegger/nvim-dap", tag = "0.*" })
	use({ "rcarriga/nvim-dap-ui", tag = "v2.*" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })
	use({ "theHamsta/nvim-dap-virtual-text", commit = "2971ce3e89b1711cc26e27f73d3f854b559a77d4" })

	-- Go
	use({ "ray-x/go.nvim", commit = "793b0d1ede7693952644c8655bba1edc243a450f" })
	use({
		"ray-x/guihua.lua",
		commit = "a55e30a8d5a44683eaeffbf3d06c39699a173954",
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
