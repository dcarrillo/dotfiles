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
	use({ "wbthomason/packer.nvim", commit = "dac4088c70f4337c6c40d1a2751266a324765797" })
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" })
	use({ "windwp/nvim-autopairs", commit = "03580d758231956d33c8dd91e2be195106a79fa4" })
	use({ "numToStr/Comment.nvim", tag = "v0.*" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "4a42b30376c1bd625ab5016c2079631d531d797a" })
	use({ "kyazdani42/nvim-web-devicons", commit = "05e1072f63f6c194ac6e867b567e6b437d3d4622" })
	use({ "akinsho/bufferline.nvim", tag = "v3.*" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "32a7382a75a52e8ad05f4cec7eeb8bbfbe80d461" })
	use({ "lewis6991/impatient.nvim", commit = "c90e273f7b8c50a02f956c24ce4804a47f18162e" })
	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.*" })
	use({ "nvim-zh/auto-save.nvim", commit = "4b59610e1318f8a89501cee9d47a0e8650f0a4d5" })
	use({ "gelguy/wilder.nvim", commit = "679f348dc90d80ff9ba0e7c470c40a4d038dcecf" })
	use({ "romgrk/fzy-lua-native", commit = "085c7d262aa35cc55a8523e8c1618d398bf717a7", run = "make" })
	use({ "mg979/vim-visual-multi", tag = "v0.*" })
	use({ "gnikdroy/projections.nvim", commit = "6820ad90343b5ec78f236bbe0e13d9c8078a0c48" })
	use({ "nvim-treesitter/nvim-treesitter", commit = "28baed769815c54b243f0df606ccb4114287e772" })
	use({ "ray-x/sad.nvim", commit = "40fadb70e5cfa5c96041cddf2282e276002e357b" })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { "MunifTanjim/nui.nvim", commit = "257da38029d3859ed111804f9d4e95b0fa993a31" },
	})
	use({ "taybart/b64.nvim", commit = "12dde6ebc3035f010833f513cfbd9abad92b28b3" })

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "42cccfe663f36b91792a350164f0695b44a031d9" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "c49ad26e894e137e401b1d294948c46327877eaf" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", tag = "v1.*" })
	use({ "rafamadriz/friendly-snippets", commit = "484fb38b8f493ceeebf4e6fc499ebe41e10aae25" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "0687eaacc634a82f4832599653ad1305fdf0c941" })
	use({ "williamboman/mason.nvim", commit = "4b8fc830fa111c22e9ceb313689b3b35cccb6779" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "aa25b4153d2f2636c3b3a8c8360349d2b29e7ae3" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "d09d7d82cc26d63673cef85cb62895dd68aab6d8" })
	use({ "RRethy/vim-illuminate", commit = "a6d0b28ea7d6b9d139374be1f94a16bd120fcda3" })
	use({ "folke/trouble.nvim", commit = "897542f90050c3230856bc6e45de58b94c700bbf" })
	use({ "glepnir/lspsaga.nvim", commit = "b7b4777369b441341b2dcd45c738ea4167c11c9e" })
	use({ "arkav/lualine-lsp-progress", commit = "56842d097245a08d77912edf5f2a69ba29f275d7" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "a606bd10c79ec5989c76c49cc6f736e88b63f0da" })
	use({ "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e58c7bbe191297b983a9e7e89420f581369" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		commit = "fab3e2212e206f4f8b3bbaa656e129443c9b802e",
		run = "make",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", tag = "v0.*" })
	use({ "sindrets/diffview.nvim", commit = "18f83302f71889b39403919b8be00d7244d1fcfc" })
	use({ "f-person/git-blame.nvim", commit = "d3afb1c57918720548effb42edec530232436378" })

	-- DAP
	use({ "mfussenegger/nvim-dap", tag = "0.*" })
	use({ "rcarriga/nvim-dap-ui", tag = "v2.*" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })
	use({ "theHamsta/nvim-dap-virtual-text", commit = "2971ce3e89b1711cc26e27f73d3f854b559a77d4" })

	-- Go
	use({ "ray-x/go.nvim", commit = "8a959ec37bc4ef2b6bb133f21a36c62fe806ca4d" })
	use({
		"ray-x/guihua.lua",
		commit = "4459ce73db68bb3ad5ef789d03e6ea4adeeafa86",
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
