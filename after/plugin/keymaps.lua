vim.keymap.set("n", "<leader>pv", function() vim.cmd("Ex") end)

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch to left window "}) 
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch to right window "}) 
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch to bottom window "})
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch to top window "}) 

vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Create a vertical split window" })
vim.keymap.set("n", "<leader>s", ":sp", { desc = "Create a horizontal split window" })

vim.api.nvim_set_keymap('n', '<leader>l', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':enew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<C-s>h", ":sb", { noremap = true, silent = true, desc = "Move buffer to new horizontal window" })
vim.keymap.set("n", "<C-s>v", ":vert sb", { noremap = true, silent = true, desc = "Move buffer to a new vertical window" })

vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()', { noremap = true, silent = true, desc = "LSP Code Actions" })

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true, desc="Toggle nvim-tree menu"})

vim.keymap.set("n", "<C-S>j", ":lua vim.diagnostic.goto_next()", { desc = "Jump to next ESLint error" })
vim.keymap.set("n", "<C-S>k", ":lua vim.diagnostic.goto_prev()", { desc = "Go to previous ESLint error" })
vim.keymap.set("n", "<C-S>x", ":lua vim.diagnostic.open_float()", { desc = "Expand ESLint error"})
