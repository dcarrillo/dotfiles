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
	use({ "wbthomason/packer.nvim", commit = "64ae65fea395d8dc461e3884688f340dd43950ba" })
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" })
	use({ "windwp/nvim-autopairs", commit = "9fa996123031b4cad100bd5afad04384a622c8a7" })
	use({ "numToStr/Comment.nvim", tag = "v0.*" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "32d9627123321db65a4f158b72b757bcaef1a3f4" })
	use({ "kyazdani42/nvim-web-devicons", commit = "05e1072f63f6c194ac6e867b567e6b437d3d4622" })
	use({ "akinsho/bufferline.nvim", tag = "v3.*" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "bfa0d99ba6f98d077dd91779841f1c88b7b5c165" })
	use({ "lewis6991/impatient.nvim", commit = "9f7eed8133d62457f7ad2ca250eb9b837a4adeb7" })
	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.*" })
	use({ "nvim-zh/auto-save.nvim", commit = "4b59610e1318f8a89501cee9d47a0e8650f0a4d5" })
	use({ "gelguy/wilder.nvim", commit = "679f348dc90d80ff9ba0e7c470c40a4d038dcecf" })
	use({ "romgrk/fzy-lua-native", commit = "085c7d262aa35cc55a8523e8c1618d398bf717a7", run = "make" })
	use({ "mg979/vim-visual-multi", tag = "v0.*" })
	use({ "gnikdroy/projections.nvim", commit = "be100ad3540952542c2a1135f39cddea8a1a00de" })
	use({ "nvim-treesitter/nvim-treesitter", commit = "507527711fdd8f701544024aeb1a9a068f986d89" })
	use({ "ray-x/sad.nvim", commit = "01b7d84f4f73c8963f5933f09e88c833757bc7d8" })
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { "MunifTanjim/nui.nvim", commit = "2a6533fb798efad7dd783311315bab8dc5eb381b" },
	})
	use({ "taybart/b64.nvim", commit = "12dde6ebc3035f010833f513cfbd9abad92b28b3" })

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "ecae454c303d5190fb0ded096205a99fae16c6d4" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "8bbaeda725d5db6e4e1be2867a64b43bf547cf06" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", tag = "v1.*" })
	use({ "rafamadriz/friendly-snippets", commit = "2379c6245be10fbf0ebd057f0d1f89fe356bf8bc" })

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "cbf8762f15fac03a51eaa2c6f983d4a5045c95b4" })
	use({ "williamboman/mason.nvim", commit = "2668bbd9427d9edddcaf42b0fd06be3a3cf373d8" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "e8bd50153b94cc5bbfe3f59fc10ec7c4902dd526" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "5d8e925d31d8ef8462832308c016ac4ace17597a" })
	use({ "RRethy/vim-illuminate", commit = "a6d0b28ea7d6b9d139374be1f94a16bd120fcda3" })
	use({ "folke/trouble.nvim", commit = "897542f90050c3230856bc6e45de58b94c700bbf" })
	use({ "glepnir/lspsaga.nvim", commit = "b7b4777369b441341b2dcd45c738ea4167c11c9e" })
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
	use({ "sindrets/diffview.nvim", commit = "c6a3d3f1de85bc67b2da62eaf266d4f8cf714fab" })
	use({ "f-person/git-blame.nvim", commit = "d3afb1c57918720548effb42edec530232436378" })

	-- DAP
	use({ "mfussenegger/nvim-dap", tag = "0.*" })
	use({ "rcarriga/nvim-dap-ui", tag = "v2.*" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })
	use({ "theHamsta/nvim-dap-virtual-text", commit = "2971ce3e89b1711cc26e27f73d3f854b559a77d4" })

	-- Go
	use({ "ray-x/go.nvim", commit = "a6e01901d2ab5227a98a239eda5e22cd9bebca2c" })
	use({
		"ray-x/guihua.lua",
		commit = "2f8939599ef04057dee6504724a2ff04fe12d758",
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
