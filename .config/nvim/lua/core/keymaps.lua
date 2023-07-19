-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

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

-- Kitty navigation
vim.g.kitty_navigator_no_mappings = 1
keymap("n", "<A-Left>", ":KittyNavigateLeft<cr>")
keymap("n", "<A-Down>", ":KittyNavigateDown<cr>")
keymap("n", "<A-Up>", ":KittyNavigateUp<cr>")
keymap("n", "<A-Right>", ":KittyNavigateRight<cr>")

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<cr>", opts)
keymap("n", "<C-Down>", ":resize +2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<cr>", opts)
keymap("n", "<C-PageDown>", ":bnext<cr>", opts)
keymap("n", "<S-h>", ":bprevious<cr>", opts)
keymap("n", "<C-PageUp>", ":bprevious<cr>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<cr>", opts)

-- LSP / Diagnostics
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap("n", "E", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
keymap("n", "gd", "<cmd>Lspsaga finder<cr>", opts)
keymap("n", "<leader>ld", "<cmd>Lspsaga goto_definition<cr>", opts)
keymap("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", opts)
keymap("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
keymap("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
keymap("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", opts)
keymap("n", "<leader>lp", "<cmd>Lspsaga peek_definition<cr>", opts)
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async=true }<cr>", opts)
keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

-- Better paste
keymap("v", "p", "P", opts)

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NeoTree
keymap("n", "<leader>e", ":Neotree toggle<cr>", opts)
keymap("n", "<leader>gg", ":Neotree float git_status<cr>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<cr>", opts)
keymap("n", "<C-p>", ":Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<cr>", opts)
keymap("n", "<leader>fc", ":Telescope commands<cr>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require'Comment.api'.toggle.linewise.current()<cr>", opts)
keymap("x", "<leader>/", "<esc><cmd>lua require'Comment.api'.toggle.linewise(vim.fn.visualmode())<cr>", opts)

-- Gitdiff
keymap("n", "<leader>df", ":DiffviewFileHistory %<cr>", opts)
keymap("n", "<leader>dc", ":DiffviewClose<cr>", opts)

-- Projections
keymap("n", "<leader>fp", ":Telescope projections<cr>", opts)

-- Base64
keymap("v", "<leader>64e", ":<c-u>lua require'b64'.encode()<cr>", opts)
keymap("v", "<leader>64d", ":<c-u>lua require'b64'.decode()<cr>", opts)

-- Illuminate
keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
keymap("n", "<a-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', { noremap = true })
