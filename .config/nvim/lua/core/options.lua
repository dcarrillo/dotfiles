vim.opt.backup = false
vim.opt.autowriteall = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.ignorecase = false
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.writebackup = false
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
-- vim.opt.cc = "80"
vim.opt.listchars = "tab: ,trail:Ç"
vim.opt.list = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h10"
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.linebreak = true
vim.opt.numberwidth = 1
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff: ]]

-- experimental
vim.opt.cmdheight = 0 -- Number of screen lines to use for the command-line
