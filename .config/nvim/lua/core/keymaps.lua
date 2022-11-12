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

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- LSP / Diagnostics
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
keymap("n", "D", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
keymap("n", "gd", "<cmd>Lspsaga lsp_finder<cr>", opts)
keymap("n", "<leader>ld", "<cmd>Lspsaga lsp_finder<cr>", opts)
keymap("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", opts)
keymap("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
keymap("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
keymap("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", opts)
keymap("n", "<leader>lp", "<cmd>Lspsaga peek_definition<cr>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NeoTree
keymap("n", "<leader>e", ":Neotree toggle<CR>", opts)
keymap("n", "<leader>gg", ":Neotree float git_status<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fc", ":Telescope commands<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require'Comment.api'.toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", "<ESC><CMD>lua require'Comment.api'.toggle.linewise(vim.fn.visualmode())<CR>")

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Session Manager
keymap("n", "<leader>so", ":SessionManager load_session<cr>", opts)
keymap("n", "<leader>sd", ":SessionManager delete_session<cr>", opts)
keymap("n", "<leader>ss", ":SessionManager save_current_session<cr>", opts)

-- Base64
keymap("v", "<leader>64e", ":<c-u>lua require'b64'.encode()<cr>", opts)
keymap("v", "<leader>64d", ":<c-u>lua require'b64'.decode()<cr>", opts)

-- Illuminate
keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
keymap("n", "<a-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', { noremap = true })
