vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.api.nvim_set_option("clipboard","unnamed")
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.smartcase = true
vim.opt.foldmethod = "indent"
vim.opt.fillchars = { fold = " " }
vim.opt.foldlevel = 99
