-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--

-- Apply q macro
keymap("n", "<F9>", "@q", vim.tbl_extend("force", opts, { desc = "Run default macro" }))

-- Kitty navigation
vim.g.kitty_navigator_no_mappings = 1
keymap("n", "<A-Left>", ":KittyNavigateLeft<cr>", vim.tbl_extend("force", opts, { desc = "Navigate left" }))
keymap("n", "<A-Down>", ":KittyNavigateDown<cr>", vim.tbl_extend("force", opts, { desc = "Navigate down" }))
keymap("n", "<A-Up>", ":KittyNavigateUp<cr>", vim.tbl_extend("force", opts, { desc = "Navigate up" }))
keymap("n", "<A-Right>", ":KittyNavigateRight<cr>", vim.tbl_extend("force", opts, { desc = "Navigate right" }))

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<cr>", vim.tbl_extend("force", opts, { desc = "Window horizontal resize -2" }))
keymap("n", "<C-Down>", ":resize +2<cr>", vim.tbl_extend("force", opts, { desc = "Window horizontal resize +2" }))
keymap(
	"n",
	"<C-Left>",
	":vertical resize -2<cr>",
	vim.tbl_extend("force", opts, { desc = "Window vertical resize -2" })
)
keymap(
	"n",
	"<C-Right>",
	":vertical resize +2<cr>",
	vim.tbl_extend("force", opts, { desc = "Window vertical resize +2" })
)

-- Navigate buffers
keymap(
	"n",
	"<C-PageDown>",
	":bnext<cr>",
	vim.tbl_extend("force", opts, { desc = "Navigate to the next buffer on the right" })
)
keymap(
	"n",
	"<C-PageUp>",
	":bprevious<cr>",
	vim.tbl_extend("force", opts, { desc = "Navigate to the previous buffer on the left" })
)

keymap("n", "<bs>", ":edit #<cr>", vim.tbl_extend("force", opts, { desc = "Back to previous file", silent = true }))

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", vim.tbl_extend("force", opts, { desc = "Clear search highlights" }))

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<cr>", vim.tbl_extend("force", opts, { desc = "Close buffer" }))

-- LSP / Diagnostics
keymap(
	"n",
	"<leader>xx",
	"<cmd>Trouble diagnostics toggle<cr>",
	vim.tbl_extend("force", opts, { desc = "Toggle trouble diganostics" })
)
keymap(
	"n",
	"<leader>xd",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	vim.tbl_extend("force", opts, { desc = "Toggle trouble buffer diganostics" })
)
keymap(
	"n",
	"K",
	"<cmd>Lspsaga hover_doc<cr>",
	vim.tbl_extend("force", opts, { desc = "Show a hover window with the documentation" })
)
keymap(
	"n",
	"E",
	"<cmd>Lspsaga show_line_diagnostics<cr>",
	vim.tbl_extend("force", opts, { desc = "Show a hover window with the diagnostics of the error" })
)
keymap(
	"n",
	"gd",
	"<cmd>Lspsaga finder<cr>",
	vim.tbl_extend("force", opts, { desc = "Show a hover window with the usage of the directive under the cursor" })
)
keymap(
	"n",
	"<leader>ld",
	"<cmd>Lspsaga goto_definition<cr>",
	vim.tbl_extend("force", opts, { desc = "Navigate to the definition of the directive under the cursor" })
)
keymap(
	"n",
	"<leader>la",
	"<cmd>Lspsaga code_action<cr>",
	vim.tbl_extend("force", opts, { desc = "Show available code actions for the line under the cursor" })
)
keymap(
	"n",
	"<leader>lj",
	"<cmd>Lspsaga diagnostic_jump_next<cr>",
	vim.tbl_extend("force", opts, { desc = "Navigate to the next diagnostic in the buffer" })
)
keymap(
	"n",
	"<leader>lk",
	"<cmd>Lspsaga diagnostic_jump_prev<cr>",
	vim.tbl_extend("force", opts, { desc = "Navigate to the previous diagnostic in the buffer" })
)
keymap(
	"n",
	"<leader>lr",
	"<cmd>Lspsaga rename mode=n<cr>",
	vim.tbl_extend("force", opts, { desc = "Open a dialog to rename a code element" })
)
keymap(
	"n",
	"<leader>lp",
	"<cmd>Lspsaga peek_definition<cr>",
	vim.tbl_extend("force", opts, { desc = "Peek the definition of the directive under the cursor" })
)
keymap({ "n", "v" }, "<leader>lf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, vim.tbl_extend("force", opts, { desc = "Format the current buffer or selection" }))

keymap({ "n", "v" }, "<leader>o", "<cmd>Outline<CR>", vim.tbl_extend("force", opts, { desc = "Toogle Outline" }))

-- Neotest
keymap(
	"n",
	"<leader>tr",
	"<cmd>RunTest<cr>",
	vim.tbl_extend("force", opts, { desc = "Run test on the current function" })
)
keymap(
	"n",
	"<leader>tf",
	"<cmd>RunTestFile<cr>",
	vim.tbl_extend("force", opts, { desc = "Run tests on the current file" })
)

-- Copilot
keymap({ "n", "v" }, "<leader>coh", function()
	local actions = require("CopilotChat.actions")
	require("CopilotChat.integrations.telescope").pick(actions.help_actions())
end, vim.tbl_extend("force", opts, { desc = "CopilotChat - Help actions" }))
keymap({ "n", "v" }, "<leader>cop", function()
	local actions = require("CopilotChat.actions")
	require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end, vim.tbl_extend("force", opts, { desc = "CopilotChat - Prompt actions" }))
keymap("n", "<leader>coq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
	end
end, vim.tbl_extend("force", opts, { desc = "CopilotChat - Quick chat" }))

-- Better paste
keymap("v", "p", "P", vim.tbl_extend("force", opts, { desc = "Paste" }))

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", vim.tbl_extend("force", opts, { desc = "Exit insert mode" }))

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NeoTree
keymap("n", "<leader>e", ":Neotree toggle<cr>", vim.tbl_extend("force", opts, { desc = "Toggle Neotree" }))
keymap(
	"n",
	"<leader>gg",
	":Neotree float git_status<cr>",
	vim.tbl_extend("force", opts, { desc = "Open a float window with the git status" })
)

-- Telescope
keymap(
	"n",
	"<leader>ff",
	":Telescope find_files<cr>",
	vim.tbl_extend("force", opts, { desc = "Open a Telescope prompt to search for files" })
)
keymap(
	"n",
	"<C-p>",
	":Telescope find_files<cr>",
	vim.tbl_extend("force", opts, { desc = "Open a Telescope prompt to search for files" })
)
keymap(
	"n",
	"<leader>fg",
	":Telescope live_grep<cr>",
	vim.tbl_extend("force", opts, { desc = "Open a Telescope prompt to search for text in all files" })
)
keymap(
	"n",
	"<leader>fk",
	":Telescope keymaps<cr>",
	vim.tbl_extend("force", opts, { desc = "Open a Telescope prompt to show all keymaps" })
)
keymap(
	"n",
	"<leader>fc",
	":Telescope commands<cr>",
	vim.tbl_extend("force", opts, { desc = "Open a Telescope prompt to show all commands" })
)

-- Gitdiff
keymap(
	"n",
	"<leader>df",
	":DiffviewFileHistory %<cr>",
	vim.tbl_extend("force", opts, { desc = "Open diff view file history for the current buffer" })
)
keymap("n", "<leader>dc", ":DiffviewClose<cr>", vim.tbl_extend("force", opts, { desc = "Close diff view" }))

-- Projects
keymap(
	"n",
	"<leader>fp",
	":Telescope neovim-project discover<cr>",
	vim.tbl_extend("force", opts, { desc = "Open a Telescope prompt to search for projects" })
)

-- Base64
keymap(
	"v",
	"<leader>64e",
	":<c-u>lua require'b64'.encode()<cr>",
	vim.tbl_extend("force", opts, { desc = "Encode the visual selected text to base64" })
)
keymap(
	"v",
	"<leader>64d",
	":<c-u>lua require'b64'.decode()<cr>",
	vim.tbl_extend("force", opts, { desc = "Decode the visual selected text from base64" })
)

-- Illuminate
keymap(
	"n",
	"<A-n>",
	"<cmd>lua require'illuminate'.next_reference{wrap=true}<cr>",
	vim.tbl_extend("force", opts, { desc = "Navigate to the next selected text by illuminate" })
)
keymap(
	"n",
	"<A-p>",
	"<cmd>lua require'illuminate'.next_reference{reverse=true,wrap=true}<cr>",
	vim.tbl_extend("force", opts, { desc = "Navigate to the previous selected text by illuminate" })
)

-- Folding
keymap(
	"n",
	"zR",
	"<cmd>lua require'ufo'.openAllFolds()<cr>",
	vim.tbl_extend("force", opts, { desc = "Open all folds" })
)
keymap(
	"n",
	"zM",
	"<cmd>lua require'ufo'.closeAllFolds()<cr>",
	vim.tbl_extend("force", opts, { desc = "Close all folds" })
)
keymap(
	"n",
	"zr",
	"<cmd>lua require'ufo'.openFoldsExceptKinds()<cr>",
	vim.tbl_extend("force", opts, { desc = "Fold less" })
)
keymap("n", "zm", "<cmd>lua require'ufo'.closeFoldsWith()<cr>", vim.tbl_extend("force", opts, { desc = "Fold more" }))
keymap(
	"n",
	"zp",
	"<cmd>lua require'ufo'.peekFoldedLinesUnderCursor()<cr>",
	vim.tbl_extend("force", opts, { desc = "Peek fold" })
)

keymap(
	"n",
	"<leader>m",
	":RenderMarkdown toggle<cr>",
	vim.tbl_extend("force", opts, { desc = "Toggle markdown rendering" })
)
