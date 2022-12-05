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
	use({ "wbthomason/packer.nvim", commit = "502a89f72ee5db3907dd0c7ee36287d49cfa56a0" })
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" })
	use({ "windwp/nvim-autopairs", commit = "99f696339266c22e7313d6a85a95bd538c3fc226" })
	use({ "numToStr/Comment.nvim", tag = "v0.*" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" })
	use({ "kyazdani42/nvim-web-devicons", commit = "189ad3790d57c548896a78522fd8b0d0fc11be31" })
	use({ "akinsho/bufferline.nvim", tag = "v3.*" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "bfa0d99ba6f98d077dd91779841f1c88b7b5c165" })
	use({ "lewis6991/impatient.nvim", commit = "d3dd30ff0b811756e735eb9020609fa315bfbbcc" })
	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.*" })
	use({ "nvim-zh/auto-save.nvim", commit = "4b59610e1318f8a89501cee9d47a0e8650f0a4d5" })
	use({ "gelguy/wilder.nvim", commit = "679f348dc90d80ff9ba0e7c470c40a4d038dcecf" })
	use({ "romgrk/fzy-lua-native", commit = "085c7d262aa35cc55a8523e8c1618d398bf717a7", run = "make" })
	use({ "mg979/vim-visual-multi", tag = "v0.*" })
	use({ "Shatur/neovim-session-manager", commit = "24ceb4bfe666ca74f52ed3821a9f778c6324a84b" })
	use({ "nvim-treesitter/nvim-treesitter", commit = "4953fdf73ef5ada18e1e969019803605f4f4a4ac" })
	use({ "ray-x/sad.nvim", commit = "01b7d84f4f73c8963f5933f09e88c833757bc7d8" })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { "MunifTanjim/nui.nvim", commit = "d12a6977846b2fa978bff89b439e509320854e10" },
	})
	use({ "taybart/b64.nvim", commit = "12dde6ebc3035f010833f513cfbd9abad92b28b3" })

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "171aface9bb47b48fbe71ef98ac5574d04812501" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "93f385c17611039f3cc35e1399f1c0a8cf82f1fb" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", tag = "v1.*" })
	use({ "rafamadriz/friendly-snippets", commit = "9b3e497cf0c3abcf73d791968a9768a22405fa13" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "e96f639b608a596aa1ea8abb7e5b799cedbb0b1a" })
	use({ "williamboman/mason.nvim", commit = "2381f507189e3e10a43c3932a3ec6c2847180abc" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "4674ed145fd0e72c9bfdb32b647f968b221bf2f2" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "b3d2ebdb75cf1fa4290822b43dc31f61bd0023f8" })
	use({ "RRethy/vim-illuminate", commit = "a6d0b28ea7d6b9d139374be1f94a16bd120fcda3" })
	use({ "folke/trouble.nvim", commit = "897542f90050c3230856bc6e45de58b94c700bbf" })
	use({ "glepnir/lspsaga.nvim", commit = "2eb8d023790099b182ac0c43d13dede80f42153e" })
	use({ "arkav/lualine-lsp-progress", commit = "56842d097245a08d77912edf5f2a69ba29f275d7" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "cabf991b1d3996fa6f3232327fc649bbdf676496" })
	use({ "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e58c7bbe191297b983a9e7e89420f581369" })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		commit = "ae9d95da9ff5669eb8e35f758fbf385b3e2fb7cf",
		run = "make",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", tag = "v0.*" })
	use({ "sindrets/diffview.nvim", commit = "bd6c0c2df6c00a72342f631a58e1ea28549b6ac8" })
	use({ "f-person/git-blame.nvim", commit = "d3afb1c57918720548effb42edec530232436378" })

	-- DAP
	use({ "mfussenegger/nvim-dap", tag = "0.*" })
	use({ "rcarriga/nvim-dap-ui", tag = "v2.*" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })
	use({ "theHamsta/nvim-dap-virtual-text", commit = "2971ce3e89b1711cc26e27f73d3f854b559a77d4" })

	-- Go
	use({ "ray-x/go.nvim", commit = "c61d2f447be009d808e36fe942d1fd68c7fd551d" })
	use({
		"ray-x/guihua.lua",
		commit = "6026fcca876e2dad6f379c856d3f31ec51bb8b54",
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
