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

local uv = vim.loop
local function readFile(path)
	local fd = uv.fs_open(path, "r", 438)
	if fd == nil then
		return nil
	end
	local stat = uv.fs_fstat(fd)
	if fd == nil then
		return nil
	end
	local data = uv.fs_read(fd, stat.size, 0)
	if data == nil then
		return nil
	end
	assert(uv.fs_close(fd))

	return data
end

local projects = function()
	local data = readFile(os.getenv("HOME") .. "/.config/nvim/neovim-projects.json")
	if data then
		return vim.json.decode(data)
	else
		return {}
	end
end

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
		config = function()
			local options = {
				darken = {
					floats = false,
					sidebars = {
						enabled = false,
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
			vim.cmd("colorscheme rose-pine-moon")
		end,
	},

	-- Plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "echasnovski/mini.starter", lazy = "VimEnter", version = "*" },
	{ "windwp/nvim-autopairs" },
	{ "numToStr/Comment.nvim", version = "v0.*" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "akinsho/bufferline.nvim", event = "VeryLazy", branch = "main" }, -- version = "v4.*" },
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
		opts = {
			projects = projects(),
			last_session_on_startup = false,
		},
		init = function()
			vim.opt.sessionoptions:append("globals")
		end,
		dependencies = {
			{ "Shatur/neovim-session-manager" },
		},
		priority = 100,
	},
	{ "nvim-treesitter/nvim-treesitter", event = "BufReadPost" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "v3.x",
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
			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
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
	-- {
	-- 	"Exafunction/codeium.nvim",
	-- 	event = "BufEnter",
	-- },

	-- Snippets
	{ "L3MON4D3/LuaSnip", version = "v2.*", event = "InsertEnter" },
	{ "rafamadriz/friendly-snippets" },

	-- LSP
	{ "neovim/nvim-lspconfig", event = "BufReadPre" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "nvimtools/none-ls.nvim", event = "BufReadPre" },
	{ "RRethy/vim-illuminate", event = "BufReadPost" },
	{ "folke/trouble.nvim" },
	{ "glepnir/lspsaga.nvim", event = "BufRead" },
	{ "arkav/lualine-lsp-progress" },

	-- Telescope
	{ "nvim-telescope/telescope.nvim", cmd = "Telescope" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Git
	{ "lewis6991/gitsigns.nvim", event = "BufReadPre", version = "v0.*" },
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

	-- Python
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"mfussenegger/nvim-dap-python",
		},
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
	{ "mzlogin/vim-markdown-toc" },
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

	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{ "zbirenbaum/copilot-cmp" },
	{ "AndreM222/copilot-lualine" },
	{
		"copilotc-nvim/copilotchat.nvim",
		branch = "canary",
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

	{ "robbles/logstash.vim" },
}, lazy_opts)
