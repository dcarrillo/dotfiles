local cmp = require("cmp")

local kind_icons = {
	Array = " ",
	Boolean = " ",
	Class = " ",
	Codeium = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Copilot = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = " ",
	Interface = " ",
	Key = " ",
	Keyword = " ",
	Method = " ",
	Module = " ",
	Namespace = " ",
	Null = " ",
	Number = " ",
	Object = " ",
	Operator = " ",
	Package = " ",
	Property = " ",
	Reference = " ",
	String = " ",
	Struct = " ",
	Text = " ",
	TypeParameter = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
}

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-q>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm(),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	cmp.select_next_item()
		-- end),
		["<C-CR>"] = function(fallback)
			cmp.abort()
			fallback()
		end,
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "[lsp]",
				buffer = "[local]",
				copilot = "[AI]",
				path = "",
				emoji = "",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "copilot" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = { enabled = true },
	},
})
