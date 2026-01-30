local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
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
			vim.cmd("colorscheme tokyonight-moon")
		end,
	},

	-- Plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "echasnovski/mini.comment", event = "VeryLazy", version = "*" },
	{ "echasnovski/mini.pairs", event = "VeryLazy", version = "*" },
	{ "echasnovski/mini.surround", event = "VeryLazy", version = "*" },
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true, opts = {
		enable_autocmd = false,
	} },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "akinsho/bufferline.nvim", event = "VeryLazy", version = "v4.*" },
	{ "moll/vim-bbye" },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
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
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
	},
	{ "taybart/b64.nvim", event = "VeryLazy" },
	{ "tenxsoydev/karen-yank.nvim", event = "VeryLazy", config = true },
	{
		"https://codeberg.org/andyg/leap.nvim",
		config = function()
			-- require("leap").add_default_mappings()
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
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			"fang2hou/blink-copilot",
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
	{ "hedyhli/outline.nvim", opts = {} },

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
		"cenk1cenk2/schema-companion.nvim",
		config = function()
			require("schema-companion").setup({})
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
		branch = "main",
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
		"brianhuster/live-preview.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown",
	},
	{ "mzlogin/vim-markdown-toc" },

	-- Copilot
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
		},
	},
	{
		"ravitemer/mcphub.nvim",
		-- cmd = "MCPHub", -- lazy load by default
		-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
		build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{ "AndreM222/copilot-lualine" },

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
}, lazy_opts)
